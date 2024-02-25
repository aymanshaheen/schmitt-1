import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isPlace;
  final Color valueColor;

  const CustomRow({
    Key? key,
    required this.title,
    required this.value,
    required this.valueColor,
    this.isPlace = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.tr(),
              style: TextStyle(
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
            ),
            if (isPlace)
              Column(
                children: [
                  SizedBox(
                    height: R.sH(context, 5),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w400,
                      color: valueColor,
                    ),
                  ),
                ],
              )
            else
              Text(
                value,
                style: TextStyle(
                  fontSize: R.F(context, 16),
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
          ],
        ),
        Divider(
          color: AppColors.grey1,
        ),
      ],
    );
  }
}
