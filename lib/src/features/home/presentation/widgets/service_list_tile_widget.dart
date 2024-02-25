import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ServiceListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color avatarColor;
  final double width;
  const ServiceListTile({super.key, 
    required this.title,
    required this.subTitle,
    required this.avatarColor,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Padding(
          padding: EdgeInsets.only(bottom: R.sH(context, 10)),
          child: SizedBox(
            width: R.sW(context, 65),
            height: R.sH(context, 65),
            child: CircleAvatar(
              backgroundColor: avatarColor,
              child: SvgPicture.asset(title,
                  width: R.sW(context, 25), height: R.sH(context, 25)),
            ),
          ),
        ),
        subtitle: Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.homeBlackColor,
            fontSize: R.F(context, 16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
