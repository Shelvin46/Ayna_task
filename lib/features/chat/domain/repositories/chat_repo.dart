import 'package:ayna_task/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

///[]
abstract class ChatRepo {
  Future<Either<Failure, WebSocketChannel>> connectToWeSocket();
}
