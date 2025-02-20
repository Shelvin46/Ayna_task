import 'dart:developer';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/features/chat/data/models/message_model/message_model.dart';
import 'package:ayna_task/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:ayna_task/features/chat/presentation/widgets/chat_title_widget.dart';
import 'package:ayna_task/features/chat/presentation/widgets/message_list_view.dart';
import 'package:ayna_task/features/chat/presentation/widgets/send_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///[ChatPage] is a stateful widget which returns a [Scaffold] widget.
///[ChatPage] contains a [SafeArea] widget which contains an [Align] widget.
///[Align] widget contains a [ConstrainedBox] widget which contains a [Column] widget.
///[Column] widget contains a [ChatTitleWidget] widget, [MessageListView] widget and [SendMessageWidget] widget.
///[MessageListView] widget contains a [GroupedListView] widget which displays the messages in a grouped list view.
///
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<MessageModel> messages = [];

  @override
  void initState() {
    // calling the event for connecting to the web socket
    context.read<ChatBloc>().add(const ConnectToWebSocket());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          // disconnect the web socket when the user leaves the chat page
          context.read<ChatBloc>().add(DisconnectWebSocket());
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 200,
                  maxWidth: 750,
                ),
                child: Column(
                  children: [
                    const ChatTitleWidget(),
                    BlocConsumer<ChatBloc, ChatState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        // check the state of the chat bloc
                        // if the state is ChatConnected, then return the stream builder
                        // to listen to the web socket
                        // if the state is ChatConnectionError, then return the error message
                        // if the state is ConnectionLoadingState, then return the loading indicator

                        if (state is ChatConnected) {
                          messages = state.messages ?? [];

                          // return the stream builder to listen to the web socket
                          return StreamBuilder<dynamic>(
                              stream: state.webSocket,
                              builder: (context, snapshot) {
                                log('snapshot: ${snapshot.data}');
                                if (snapshot.hasData) {
                                  // save the message to the local storage
                                  MessageModel message = MessageModel(
                                    message: snapshot.data,
                                    time: DateTime.now(),
                                    sender: 'Ayna',
                                  );
                                  messages.insert(0, message);
                                }
                                return Column(
                                  children: [
                                    10.heightBox,

                                    10.heightBox,
                                    // write the code for grouped list view here
                                    MessageListView(messages: messages),

                                    10.heightBox,
                                  ],
                                ).expanded();
                              });
                        } else if (state is ChatConnectionError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          );
                        } else if (state is ConnectionLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SendMessageWidget(),
                    20.heightBox,
                  ],
                )),
          ),
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
