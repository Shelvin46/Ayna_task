import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'message_model.g.dart';

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
