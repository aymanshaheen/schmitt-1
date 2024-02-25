import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class CustomRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const CustomRow({super.key, 
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label.tr(),
              style: TextStyle(
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(
          height: R.sH(context, 10),
        ),
      ],
    );
  }
}