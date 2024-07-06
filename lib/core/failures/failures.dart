import 'package:equatable/equatable.dart';

///[Failure] is an class that is used to handle errors in the application
class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
  @override
  List<Object> get props => [message];
}

class NetworkException extends Failure {
  const NetworkException({required super.message});
}

class APIException extends Failure {
  const APIException({required super.message});
}

class ParsingException extends Failure {
  const ParsingException({required super.message});
}

class CustomTimeoutException extends Failure {
  const CustomTimeoutException({required super.message});
}
