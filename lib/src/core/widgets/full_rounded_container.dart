import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class FullRounderContainer extends StatelessWidget {
  final String title;
  final double circular;
  final Color containerColor;
  final Color textColor;
  const FullRounderContainer(
      {super.key,
      required this.title,
      required this.containerColor,
      required this.textColor,
      required this.circular});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: R.sW(context, 320),
      height: R.sH(context, 55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(circular),
        color: containerColor,
        border: Border.all(
          color: textColor,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: R.F(context, 16),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
