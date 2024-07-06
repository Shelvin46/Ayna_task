part of 'chat_bloc.dart';

///[ChatState] is a class that extends [Equatable] which is a class that helps to compare objects of the same type.
///[ChatInitial] is a class that extends [ChatState] which is a class that helps to manage the state of the application.
///[ConnectionLoadingState] this is a loading state that is used to show the loading state of the connection.
///[ChatConnected] this is a state that is used to show the connection is connected.
///[ChatDisconnected] this is a state that is used to show the connection is disconnected.
///[ChatConnectionError] this is a state that is used to show the connection error.
sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ConnectionLoadingState extends ChatState {
  const ConnectionLoadingState();

  @override
  List<Object> get props => [];
}

final class ChatConnected extends ChatState {
  final Stream<dynamic> webSocket;
  final List<MessageModel>? messages;
  const ChatConnected({required this.webSocket, this.messages});

  @override
  List<Object> get props => [webSocket, messages ?? []];
}

//error state
final class ChatConnectionError extends ChatState {
  final String message;

  const ChatConnectionError(this.message);

  @override
  List<Object> get props => [message];
}

final class ChatDisconnected extends ChatState {
  final bool isDisconnected;

  const ChatDisconnected(this.isDisconnected);

  @override
  List<Object> get props => [isDisconnected];
}
