import 'package:flutter/material.dart';
import 'package:schmitt/src/core/extensions/time_extension.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message.dart';

class TimeSentWidget extends StatelessWidget {
  const TimeSentWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message.timeSent.amPmMode,
            style: TextStyle(
              fontSize: 13,
              color: isMe ? AppColors.white : AppColors.grey,
            ),
          ),
          SizedBox(
            width: R.sW(context, 7),
          ),
          if (isMe)
            Icon(
              Icons.done_all,
              size: 20,
              color: message.isSeen ? AppColors.darkBlue : AppColors.white,
            ),
        ],
      ),
    );
  }
}
