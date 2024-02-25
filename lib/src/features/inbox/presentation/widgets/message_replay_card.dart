import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/enum.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/presentation/cubit/chat_cubit/chat_cubit.dart';

class ReplayMessageCard extends StatelessWidget {
  final bool showCloseButton;
  final MessageType repliedMessageType;
  final String text;
  final bool isMe;
  final String repliedTo;

  //final MessageReplay messageReplay;

  const ReplayMessageCard({
    super.key,
    this.showCloseButton = false,
    required this.repliedMessageType,
    required this.text,
    required this.isMe,
    required this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: EdgeInsets.only(
          left: R.sW(context, 10),
          right: R.sW(context, 5),
          top: R.sH(context, 6),
          bottom: R.sH(context, 8),
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          border: Border(
            left: BorderSide(
              color: !isMe ? AppColors.darkBlue : AppColors.grey,
              width: R.sW(context, 5),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isMe ? 'you'.tr() : repliedTo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe ? AppColors.darkBlue : AppColors.grey,
                    ),
                  ),
                ),
                if (showCloseButton)
                  GestureDetector(
                    onTap: () {
                      ChatCubit.get(context).cancelReplay();
                    },
                    child: Icon(
                      Icons.close,
                      size: R.sW(context, 16),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 8),
            ReplayMessageContent(
              repliedMessageType: repliedMessageType,
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}

class ReplayMessageContent extends StatelessWidget {
  final MessageType repliedMessageType;
  final String text;

  const ReplayMessageContent({
    super.key,
    required this.repliedMessageType,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    switch (repliedMessageType) {
      case MessageType.text:
        return Text(
          text,
          style: TextStyle(color: AppColors.white, fontSize: R.sW(context, 14)),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
      case MessageType.image:
        return Row(
          children: [
            Icon(
              Icons.image,
              color: AppColors.black,
            ),
            SizedBox(
              width: R.sW(context, 4),
            ),
            Text(
              'Photo',
              style: TextStyle(
                  color: AppColors.black, fontSize: R.sW(context, 14)),
            ),
          ],
        );
      case MessageType.video:
        return Row(
          children: [
            const Icon(Icons.videocam),
            Text(
              'Video',
              style: TextStyle(
                  color: AppColors.black, fontSize: R.sW(context, 14)),
            ),
          ],
        );
      case MessageType.audio:
        return Row(
          children: [
            Icon(
              Icons.mic,
              size: 18,
              color: AppColors.black,
            ),
            Text(
              'Voice message',
              style: TextStyle(
                  color: AppColors.black, fontSize: R.sW(context, 14)),
            ),
          ],
        );
      default:
        return Text(
          text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        );
    }
  }
}
