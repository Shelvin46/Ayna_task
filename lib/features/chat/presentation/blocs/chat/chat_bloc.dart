import 'dart:async';
import 'dart:developer';
import 'package:ayna_task/core/exception/exception_handler.dart';
import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/core/services/hive_local_storage_service.dart';
import 'package:ayna_task/features/chat/data/models/message_model/message_model.dart';
import 'package:ayna_task/features/chat/data/models/user_model/user_model.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/html.dart';

part 'chat_event.dart';
part 'chat_state.dart';

///[ChatBloc] is a class that extends [Bloc] which is a class that helps to manage the state of the application.
///[ChatInitial] is a class that extends [ChatState] which is a class that helps to manage the state of the application.
///[ConnectToWebSocket] is a class that extends [ChatEvent] which is a class that helps to compare objects of the same type.
///[MessageSendEvent] is a class that extends [ChatEvent] which is a class that helps to compare objects of the same type.
/// `web_socket` is a variable of type [HtmlWebSocketChannel] which is used to connect to the web socket.
/// `streamSubscription` is a variable of type [Stream<dynamic>] which is used to listen to the web socket.
/// `userIdForMessage` is a variable of type [UserModel] which is used to get the user id.
/// `userId` is a variable of type [String] which is used to store the user id.
/// `url` is a variable of type [Uri] which is used to store the url of the web socket.
/// [ChatConnected] is a class that extends [ChatState] which is a class is used when the chat is connected.
///[ConnectionLoadingState] is a class that extends [ChatState] which is a class that is used when the chat is loading.
///[ChatConnectionError] is a class that extends [ChatState] which is a class that helps to manage the error state of the chat.
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    late HtmlWebSocketChannel webSocket;
    late Stream<dynamic> streamSubscription;

    on<ConnectToWebSocket>((event, emit) async {
      emit(const ConnectionLoadingState());

      UserModel? userIdForMessage = locator<HiveStorageService>().getUserId(
        "Ayna",
      );
      String userId = userIdForMessage?.id ?? '';

      if (userIdForMessage == null) {
        var uuid = const Uuid();
        userId = uuid.v4(); // Generates a new UUID
        locator<HiveStorageService>().saveUserId(userId, "Ayna");
      }

      try {
        final url = Uri.parse('wss://echo.websocket.org/');
        webSocket = HtmlWebSocketChannel.connect(url);

        // Convert the stream to a broadcast stream
        streamSubscription = webSocket.stream.asBroadcastStream();

        streamSubscription.listen(
          (event) {
            log('event: $event');

            // save the message to the local storage
            MessageModel message = MessageModel(
              messageId: userId,
              message: event,
              time: DateTime.now(),
              sender: 'Ayna',
            );
            // save the message that comes on the web socket into local hive storage
            locator<HiveStorageService>().saveMessage(message);
          },
          onError: (error) {
            return emit(ChatConnectionError(error.toString()));
          },
        );
      }
      // Handle the exceptions
      catch (e) {
        Failure failure = CustomExceptionHandler.handleException(e);
        return emit(ChatConnectionError(failure.message));
      }
      log('userIdForMessage: $userIdForMessage');
      // get all the messages from the local storage
      locator<HiveStorageService>().getAllMessages(userId).then((messages) {
        log('messages: $messages');
        return emit(
          ChatConnected(
            webSocket: streamSubscription,
            messages: messages.reversed.toList(),
          ),
        );
      });
    });
    // Send the message to the web socket
    on<MessageSendEvent>((event, emit) {
      webSocket.sink.add(event.message);
    });
    // Disconnect the web socket
    on<DisconnectWebSocket>((event, emit) {
      webSocket.sink.close();
    });
  }
}
