import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'message_model.g.dart';

///[MessageModel] is a class that extends [Equatable] which is a class that helps to compare objects of the same type.
///[MessageModel] is a class that is used to store the message details.
///[message] is a variable of type [String] which is used to store the message.
///[sender] is a variable of type [String] which is used to store the sender of the message.
///[time] is a variable of type [DateTime] which is used to store the time of the message.
///[messageId] is a variable of type [String] which is used to store the message id.

@HiveType(typeId: 1)
class MessageModel extends Equatable {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final String sender;

  @HiveField(2)
  final DateTime time;

  @HiveField(3)
  final String messageId;

  const MessageModel({
    required this.message,
    required this.sender,
    required this.time,
    this.messageId = '',
  });

  @override
  List<Object?> get props => [message, sender, time, messageId];
}
