import 'package:ayna_task/core/services/shared_pref_services.dart';
import 'package:ayna_task/features/chat/data/models/message_model/message_model.dart';
import 'package:ayna_task/features/chat/data/models/user_model/user_model.dart';
import 'package:ayna_task/firebase_options.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:ayna_task/theme_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

///[main] is the entry point of the web app.
///[main] calls [MyApp] widget.
///[main] calls [WidgetsFlutterBinding.ensureInitialized()] to ensure that the app is initialized.
///[main] calls [Firebase.initializeApp()] to initialize the firebase web app.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setup the locator
  ServiceLocator.setupLocator();
  // init the shared preferences local storage
  await locator<SharedPreferencesService>().init();
  // init the firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');
  await Hive.openBox<MessageModel>('messagesBox');
  runApp(MyApp());
}
