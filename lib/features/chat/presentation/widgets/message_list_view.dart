import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:ayna_task/features/chat/data/models/message_model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({
    super.key,
    required this.messages,
  });

  final List<MessageModel> messages;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GroupedListView<MessageModel, DateTime>(
        reverse: true,
        shrinkWrap: true,
        primary: false,
        sort: false,
        physics: const ScrollPhysics(),
        elements: widget.messages,
        groupBy: (message) => DateTime(
          message.time.year,
          message.time.month,
          message.time.day,
        ),
        groupHeaderBuilder: (MessageModel message) => SizedBox(
          height: 40,
          child: Align(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${message.time.month}/${message.time.day}/${message.time.year}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ),
        itemBuilder: (context, MessageModel message) => Align(
          alignment:
              message.sender == "Ayna" ? Alignment.topRight : Alignment.topLeft,
          child: Column(
            children: [
              20.heightBox,
              Container(
                decoration: BoxDecoration(
                  color: message.sender == "Ayna"
                      ? Colors.blue[500]
                      : Colors.grey[500],
                  borderRadius: BorderRadius.circular(5.0),
                ),
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message.message,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
