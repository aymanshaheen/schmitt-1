import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class BottomTextFeild extends StatefulWidget {
  final String labelText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const BottomTextFeild({
    super.key,
    required this.labelText,
    required this.validator,
    required this.controller,
    required this.keyboardType,
  });

  @override
  State<BottomTextFeild> createState() => _BottomTextFeildState();
}

class _BottomTextFeildState extends State<BottomTextFeild> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: R.F(context, 14),
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.grey1,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.darkBlue,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.darkBlue,
          ),
        ),
      ),
      onChanged: (String value) {},
      autocorrect: false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
    );
  }
}
