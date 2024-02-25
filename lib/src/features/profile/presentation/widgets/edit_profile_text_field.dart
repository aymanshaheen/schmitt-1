import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class EditProfileField extends StatelessWidget {
  final String hintText;
  final bool? isTextFieldEnabled;
  final bool? isPhoneNumber;

  final TextEditingController? controller;
  const EditProfileField({
    super.key,
    required this.hintText,
    this.controller,
    this.isTextFieldEnabled,
    this.isPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: R.sH(context, 65),
      decoration: BoxDecoration(
        color: AppColors.editProfileTextFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: R.sW(context, 20),
        vertical: R.sH(context, 10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: R.sW(context, 10)),
        child: Center(
          child: TextFormField(
            controller: controller,
            enabled: isTextFieldEnabled ?? true,
            style: TextStyle(
              color: AppColors.black,
              fontSize: R.F(context, 14),
            ),
            keyboardType: isPhoneNumber ?? false
                ? TextInputType.phone
                : TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              hintText: hintText.tr(),
            ),
          ),
        ),
      ),
    );
  }
}
