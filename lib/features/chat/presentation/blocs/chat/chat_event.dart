part of 'chat_bloc.dart';

///[ChatEvent] is a class that extends [Equatable] which is a class that helps to compare objects of the same type.
///[ConnectToWebSocket] is a class that extends [ChatEvent] which is a class that helps to compare objects of the same type.
///[DisconnectWebSocket] is a class that extends [ChatEvent] which is a class that helps to compare objects of the same type.
///[MessageSendEvent] is a class that extends [ChatEvent] which is a class that helps to compare objects of the same type.
sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ConnectToWebSocket extends ChatEvent {
  const ConnectToWebSocket();

  @override
  List<Object> get props => [];
}

final class MessageSendEvent extends ChatEvent {
  final String message;

  const MessageSendEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class DisconnectWebSocket extends ChatEvent {}
