import 'package:ayna_task/core/failures/failures.dart';
import 'package:ayna_task/features/chat/domain/repositories/chat_repo.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatUsecases {
  Future<Either<Failure, WebSocketChannel>> executeWebSocketConnection() async {
    return await locator<ChatRepo>().connectToWeSocket();
  }
}
