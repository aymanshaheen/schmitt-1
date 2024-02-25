import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message_replay.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_replay_card.dart';

class MessageReplayPreview extends StatelessWidget {
  final MessageReplay messageReplay;

  const MessageReplayPreview({
    super.key,
    required this.messageReplay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(R.sW(context, 5)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: ReplayMessageCard(
        showCloseButton: true,
        isMe: messageReplay.isMe,
        text: messageReplay.message,
        repliedMessageType: messageReplay.messageType,
        repliedTo: messageReplay.repliedTo,
      ),
    );
  }
}
