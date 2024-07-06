import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  SendMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type a message',
          ),
        ).flexible(),
        IconButton(
          icon: const Icon(
            Icons.send,
            size: 40,
          ),
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              context.read<ChatBloc>().add(
                    MessageSendEvent(
                      message: controller.text.trim(),
                    ),
                  );
              controller.clear();
            }
          },
        )
      ],
    );
  }
}
