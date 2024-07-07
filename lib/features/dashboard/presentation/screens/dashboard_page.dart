import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/core/services/firebase_service.dart';
import 'package:ayna_task/core/services/hive_local_storage_service.dart';
import 'package:ayna_task/core/services/shared_pref_services.dart';
import 'package:ayna_task/features/authentication/domain/entities/user_entity.dart';
import 'package:ayna_task/features/dashboard/presentation/blocs/dashboard_info/dashboard_info_bloc.dart';
import 'package:ayna_task/features/dashboard/presentation/widgets/chat_tile.dart';
import 'package:ayna_task/features/widgets/hover_text.dart';
import 'package:ayna_task/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart' as go_router;
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

///[DashboardPage] is the main page of the application
///It shows the user name and the chat list
///It also shows the logout button
///It uses [DashboardInfoBloc] to get the user name
///It uses [ChatTile] to show the chat list
///It uses [HoverText] to show the logout button
///
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // check if the user is logged in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locator<FirebaseAuthenticationService>().initialize().onData(
        (data) {
          if (data != null) {
            // Now it's safe to use context
            context.read<DashboardInfoBloc>().add(
                  DashboardInfoFetch(
                    userEntity: UserEntity(
                      email: data.email ?? "",
                      password: "",
                    ),
                  ),
                );
          } else {
            // When the user is not logged in, navigate to the login page
            debugPrint("User is not logged in");
            locator<SharedPreferencesService>().prefs.clear();
            // redirect to the login screen
            context.go('/login-screen');
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 750,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.heightBox,
                  BlocConsumer<DashboardInfoBloc, DashboardInfoState>(
                    listener: (context, state) {
                      if (state is DashboardInfoError) {
                        // show the error message
                        Fluttertoast.showToast(
                          msg: state.message,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          webBgColor: 'red',
                          fontSize: 16.0,
                          webPosition: "center",
                        );
                      }
                    },
                    builder: (context, state) {
                      // show the user name
                      if (state is DashboardInfoLoaded) {
                        return Row(
                          children: [
                            Text(
                              "Hi, ${state.userName}",
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const Spacer(),
                            HoverText(
                              text: "Logout",
                              onTap: () {
                                context.go('/login-screen');
                                // clear the shared preferences and sign out the user
                                locator<SharedPreferencesService>()
                                    .prefs
                                    .clear();
                                // clear the local storage
                                locator<HiveStorageService>()
                                    .clearHiveStorage();

                                // sign out the user from the firebase
                                locator<FirebaseAuthenticationService>()
                                    .signOut();
                              },
                            ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          Text(
                            "Hi, User",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const Spacer(),
                          HoverText(
                            text: "Logout",
                            onTap: () {
                              context.go('/login-screen');
                              // clear the shared preferences and sign out the user
                              locator<SharedPreferencesService>().prefs.clear();
                              // clear the local storage
                              locator<HiveStorageService>().clearHiveStorage();

                              // sign out the user from the firebase
                              locator<FirebaseAuthenticationService>()
                                  .signOut();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  50.heightBox,
                  // show the chat list
                  ValueListenableBuilder(
                    valueListenable: locator<HiveStorageService>()
                            .getLastMessageListenable() ??
                        ValueNotifier<Box?>(null),
                    builder: (context, box, child) {
                      final lastMessage = (box as Box?)?.values.last;
                      if (lastMessage == null || lastMessage.time == null) {
                        return buildChatTile(
                          context,
                          "no messages",
                          DateFormat('dd-MM-yyyy').format(
                            DateTime.now(),
                          ),
                        );
                      }
                      String formattedTime =
                          DateFormat('dd-MM-yyyy').format(lastMessage.time);
                      return buildChatList(
                          context, lastMessage.message, formattedTime);
                    },
                  ),
                ],
              ),
            ),
          ),
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  ///[buildChatList] is a method to build the chat list using the [ListView.separated] widget
  Widget buildChatList(
      BuildContext context, String message, String formattedTime) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          buildChatTile(context, message, formattedTime),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: 1,
    );
  }

  ///[buildChatTile] is a method to build the chat tile using the [ChatTile] widget
  Widget buildChatTile(
      BuildContext context, String message, String formattedTime) {
    return GestureDetector(
      onTap: () {
        go_router.GoRouter.of(context).push('/chat-page');
      },
      child: ChatTile(
        lastMessage: message,
        time: formattedTime,
      ),
    );
  }
}
