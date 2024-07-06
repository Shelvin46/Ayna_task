import 'dart:async';

import 'package:ayna_task/features/chat/data/models/message_model/message_model.dart';
import 'package:ayna_task/features/chat/data/models/user_model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService {
  Box<UserModel> get _userBox => Hive.box<UserModel>('userBox');
  Box<MessageModel> get _messagesBox => Hive.box<MessageModel>('messagesBox');

  Future<void> saveUserId(String userId, String name) async {
    var user = UserModel(name: name, id: userId);
    await _userBox.put(user.name, user);
  }

  UserModel? getUserId(String name) {
    return _userBox.get(name);
  }

  Future<void> saveMessage(MessageModel model) async {
    await _messagesBox.add(model);
  }

  MessageModel? getMessage(MessageModel model) {
    return _messagesBox.get(model.messageId);
  }

  ValueListenable<Box<MessageModel>>? getLastMessageListenable() {
    if (_messagesBox.isNotEmpty) {
      return _messagesBox.listenable();
    } else {
      return null;
    }
  }

  Future<void> deleteMessage(MessageModel model) async {
    await _messagesBox.delete(model.messageId);
  }

// Modified getAllMessages method to filter by id
// one particular person will have a unique id that id will be used to filter the messages
// the each message will have a unique id that is same as the id of the person
  Future<List<MessageModel>> getAllMessages(String id) async {
    // Assuming _messagesBox is a Hive box that stores MessageModel objects
    List<MessageModel> messages = _messagesBox.values.toList();

    return messages;
  }
}
