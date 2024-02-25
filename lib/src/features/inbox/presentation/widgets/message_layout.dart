import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class MessageLayoutWidget extends StatelessWidget {
  final String text;
  final String time;
  final Color color;
  final TextAlign align;
  final CrossAxisAlignment boxAlign;
  final CrossAxisAlignment crossAlign;
  final String name;
  final TextAlign alignName;
  final BubbleNip nip;

  const MessageLayoutWidget({super.key, 
    required this.text,
    required this.time,
    required this.color,
    required this.align,
    required this.boxAlign,
    required this.crossAlign,
    required this.name,
    required this.alignName,
    required this.nip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Container(
            padding: EdgeInsets.all(R.sW(context, 8)),
            margin: EdgeInsets.all(R.sW(context, 2)),
            child: Bubble(
              color: color,
              nip: nip,
              child: Column(
                crossAxisAlignment: crossAlign,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    textAlign: align,
                    style: TextStyle(
                        fontSize: R.F(context, 16),
                        color: name != "Me" ? AppColors.black : AppColors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    time,
                    textAlign: align,
                    style: TextStyle(
                        fontSize: R.F(context, 12),
                        color: name != "Me" ? AppColors.grey : AppColors.grey1),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
