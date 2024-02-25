import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomRow extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const CustomRow(
      {Key? key, required this.text1, required this.text2, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: R.F(context, 16),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(width: R.sW(context, 5)),
        InkWell(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              fontSize: R.F(context, 16),
              fontWeight: FontWeight.bold,
              color: AppColors.darkBlue,
            ),
          ),
        ),
      ],
    );
  }
}
