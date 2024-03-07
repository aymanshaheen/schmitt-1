import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/widgets/search_text_field.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: R.sW(context, 25),
                  child: ClipOval(
                      child: CircularImageBuilder(
                          photo: AppConstants.profile!.avatar!,
                          height: R.sW(context, 50),
                          width: R.sW(context, 50))),
                ),
                SizedBox(
                  width: R.sW(context, 8),
                ),
                Padding(
                  padding: EdgeInsets.only(top: R.sH(context, 2)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'good_morning'.tr()} 👋',
                          style: TextStyle(
                            color: AppColors.homeGreyColor,
                            fontSize: R.F(context, 14),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.20,
                          ),
                        ),
                        SizedBox(
                          height: R.sH(context, 2),
                        ),
                        Text(
                          AppConstants.profile!.name!,
                          style: TextStyle(
                            fontSize: R.F(context, 18),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.notifications),
                        child: SvgPicture.asset(
                            'assets/images/notifications.svg')),
                    SizedBox(
                      width: R.sW(context, 15),
                    ),
                    InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.bookmarks),
                        child:
                            SvgPicture.asset('assets/images/favourites.svg')),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: R.sH(context, 15),
        ),
        Text("العنووووووان"),
        const SearchTextField(),
        SizedBox(
          height: R.sH(context, 10),
        ),
      ],
    );
  }
}
