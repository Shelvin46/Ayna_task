import 'dart:io';

import 'package:ayna_task/core/exception/exception_handler.dart';
import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/chat/domain/repositories/chat_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

///[ChatRepoImplementation] is the class to implement the [ChatRepo] abstract class.
///[connectToWeSocket] is the method to connect to the web socket.
///[WebSocket.connect] is the method to connect to the web socket.
///[wss://echo.websocket.org/.ws] is the url to connect to the web socket.
class ChatRepoImplementation implements ChatRepo {
  @override
  Future<Either<Failure, WebSocketChannel>> connectToWeSocket() async {
    try {
      final url = Uri.parse('wss://echo.websocket.org/');
      final WebSocketChannel webSocket = HtmlWebSocketChannel.connect(url);
      return Right(webSocket);
    } catch (e) {
      return Left(CustomExceptionHandler.handleException(e));
    }
  }
}
