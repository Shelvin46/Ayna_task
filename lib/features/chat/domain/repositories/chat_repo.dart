import 'package:ayna_task/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

///[ChatRepo] is an abstract class that has a method [connectToWeSocket] used to connect to the web socket
///that returns [Either<Failure, WebSocketChannel>]
///If the process is successful, it returns [Right<WebSocketChannel>]
///If the process is unsuccessful, it returns [Left<Failure>]
abstract class ChatRepo {
  Future<Either<Failure, WebSocketChannel>> connectToWeSocket();
}
