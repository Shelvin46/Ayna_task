import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/chat/domain/repositories/chat_repo.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// [ChatUsecases] is a class that contains the fetch chat usecase.
/// It calls [ChatRepo] to connect to the web socket.
/// It returns [Either<Failure, WebSocketChannel>]
/// If the process is successful, it returns [Right<WebSocketChannel>]
/// If the process is unsuccessful, it returns [Left<Failure>]
class ChatUsecases {
  Future<Either<Failure, WebSocketChannel>> executeWebSocketConnection() async {
    return await locator<ChatRepo>().connectToWeSocket();
  }
}
