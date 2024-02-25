import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomSecurityButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomSecurityButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: R.sW(context, R.W(context) * 0.9),
      height: R.sH(context, 50),
      decoration: BoxDecoration(
        color: AppColors.securityBottonBgrndColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'Change PIN',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1C4274),
            fontSize: 16,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
            height: 0.09,
            letterSpacing: 0.20,
          ),
        ),
      ),
    );
  }
}
