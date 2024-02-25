import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class BookingButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BookingButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: R.sH(context, 50),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.darkBlue,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: AppColors.white,
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
