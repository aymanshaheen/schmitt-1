import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({super.key, required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        children: <Widget>[
          Container(
            width: R.sW(context, 20),
            height: R.sH(context, 20),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: widget.value ? AppColors.darkBlue : Colors.transparent,
              border: Border.all(
                width: 1.4,
                color: AppColors.darkBlue,
              ),
            ),
            child: widget.value
                ? Center(
                    child: Icon(
                      Icons.check,
                      size: R.sW(context, 16),
                      color: AppColors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(width: R.sW(context, 10)),
          Text(
            'remember_me'.tr(),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
