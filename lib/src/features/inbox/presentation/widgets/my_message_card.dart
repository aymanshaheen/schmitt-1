import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/first_message_small_curved_bubble.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_content/message_content.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_replay_card.dart';
import 'package:swipe_to/swipe_to.dart';

class MyMessageCard extends StatelessWidget {
  final Message message;
  final bool isFirst;

  const MyMessageCard({
    super.key,
    required this.message,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final isReplying = message.repliedMessage.isNotEmpty;
    return SwipeTo(
      onRightSwipe: (details) {
        ChatCubit.get(context).onMessageSwipe(
          message: message.text,
          isMe: true,
          messageType: message.messageType,
          repliedTo: message.senderName,
        );
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(
              top: R.sH(context, 5),
              right: isFirst ? R.sH(context, 5) : R.sH(context, 15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: R.W(context) * 0.8,
                  maxHeight: R.sH(context, 600),
                ),
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(0),
                  color: AppColors.darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: EasyLocalization.of(context)!
                                .currentLocale
                                ?.languageCode ==
                            'ar'
                        ? BorderRadius.only(
                            topRight: const Radius.circular(10),
                            bottomRight: const Radius.circular(10),
                            bottomLeft: const Radius.circular(10),
                            topLeft: isFirst
                                ? Radius.zero
                                : const Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topLeft: const Radius.circular(10),
                            bottomLeft: const Radius.circular(10),
                            bottomRight: const Radius.circular(10),
                            topRight: isFirst
                                ? Radius.zero
                                : const Radius.circular(10),
                          ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isReplying)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ReplayMessageCard(
                            text: message.repliedMessage,
                            repliedMessageType: message.repliedMessageType,
                            isMe: message.repliedTo == message.senderName,
                            repliedTo: message.repliedTo,
                          ),
                        ),
                      MessageContent(
                        message: message,
                        isMe: true,
                      ),
                    ],
                  ),
                ),
              ),
              if (isFirst)
                const FirstMessageSmallCurvedBubble(
                  isMe: true,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
