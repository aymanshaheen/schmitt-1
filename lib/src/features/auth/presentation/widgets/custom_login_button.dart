import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomLoginButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.darkBlue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: isLoading
            ? AnimatedContainer(
                key: const ValueKey<int>(1),
                height: R.sH(context, 50),
                width: R.sW(context, 20),
                duration: const Duration(milliseconds: 600),
                child: CircularIndicator(
                  color: AppColors.white,
                ))
            : AnimatedContainer(
                key: const ValueKey<int>(2),
                height: R.sH(context, 50),
                width: double.infinity,
                duration: const Duration(milliseconds: 600),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
      ),
    );
  }
}
