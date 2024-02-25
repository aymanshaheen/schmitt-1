import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: AppColors.lightGrey,
            endIndent: 5,
            thickness: 1,
          ),
        ),
        Text(text),
        Expanded(
          child: Divider(
            color: AppColors.lightGrey,
            indent: 5,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
