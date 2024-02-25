import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/inbox/domain/entities/message.dart';
import 'package:schmitt/src/features/inbox/presentation/widgets/message_content/time_sent_widget.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.message,
    required this.isMe,
  });

  final Message message;
  final bool isMe;
  bool isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(R.sW(context, 8)),
          child: Text(
            message.text,
            textAlign:
                isArabic(message.text) ? TextAlign.right : TextAlign.left,
            style: TextStyle(
              fontSize: R.F(context, 16),
              color: isMe ? AppColors.white : AppColors.black,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
        TimeSentWidget(
          message: message,
          isMe: isMe,
        ),
      ],
    );
  }
}
