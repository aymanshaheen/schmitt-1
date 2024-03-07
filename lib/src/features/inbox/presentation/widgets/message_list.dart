import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/extensions/time_extension.dart';
import 'package:schmitt/src/core/functions/date_converter.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/chat_time_widget.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/my_message_card.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/sender_message_card.dart';

class MessageListWidget extends StatefulWidget {
  final String receiverId;
  const MessageListWidget({Key? key, required this.receiverId}) : super(key: key);

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  final ScrollController _scrollController = ScrollController();
    Stream<List<Message>>? messageStream;

  @override
  void initState() {
    super.initState();
    messageStream = ChatCubit.get(context).getChatMessages(widget.receiverId);
  }

  void scrollToBottom() {
    final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFirst = false;
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return Expanded(
        child: StreamBuilder<List<Message>>(
          stream: messageStream,
          builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
            //to scroll  to bottom
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.position.maxScrollExtent.isFinite) {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              }
            });
            return ListView.builder(
              controller: _scrollController,
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var message = snapshot.data![index];
                isFirst = false;
                var priviesMessage =
                    (index > 0) ? snapshot.data![index - 1] : null;
                if (index == 0 ||
                    message.senderId != priviesMessage!.senderId ||
                    !message.timeSent.isSameDay(priviesMessage.timeSent)) {
                  isFirst = true;
                }
                //set chat message seen
                if (!message.isSeen &&
                    message.receiverId != widget.receiverId) {
                  ChatCubit.get(context).setChatMessageSeen(
                    receiverId: widget.receiverId,
                    messageId: message.messageId,
                  );
                }
                return Column(
                  children: [
                    if (index == 0 ||
                        !ConverterDate.isSameDay(
                          message.timeSent,
                          snapshot.data![index - 1].timeSent,
                        ))
                      ChatTimeCard(dateTime: message.timeSent),
                    if (message.receiverId == widget.receiverId)
                      MyMessageCard(
                        message: message,
                        isFirst: isFirst,
                      ),
                    if (message.receiverId != widget.receiverId)
                      SenderMessageCard(
                        message: message,
                        isFirst: isFirst,
                      ),
                  ],
                );
              },
            );
          },
        ),
      );
    });
  }
}
