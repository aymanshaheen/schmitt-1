import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class HalfRounderContainer extends StatelessWidget {
  final String title;
  final Color containerColor;
  final Color textColor;
  const HalfRounderContainer(
      {super.key,
      required this.title,
      required this.containerColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: R.sW(context, 140),
      height: R.sH(context, 55),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: containerColor,
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
