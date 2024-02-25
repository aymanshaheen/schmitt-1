import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:schmitt/src/features/home/presentation/widgets/home_text_tile.dart';
import 'package:schmitt/src/features/home/presentation/widgets/offers_home_listview_item.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_list_tile_widget.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      AppImage.houseKeeping,
      AppImage.houseKeeping,
      AppImage.houseKeeping,
      AppImage.houseKeeping,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeTextTile(
          rightText: 'see_all',
          leftText: 'special_offers',
          onTab: () {},
        ),
        SizedBox(
          height: R.sH(context, 15),
        ),
        CustomHomeTabController(
          imgList: imgList,
        ),
        SizedBox(
          height: R.sH(context, 15),
        ),
        Text(
          'services'.tr(),
          style: TextStyle(
            fontSize: R.F(context, 20),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: R.sH(context, 15),
        ),
        Row(children: [
          ServiceListTile(
            title: 'assets/images/car.svg',
            subTitle: 'carWash'.tr(),
            width: R.sW(context, 115),
            avatarColor: AppColors.homeGreyAvatar,
          ),
          ServiceListTile(
            width: R.sW(context, 115),
            title: 'assets/images/cleaning.svg',
            subTitle: 'housekeepings'.tr(),
            avatarColor: AppColors.homeGreenAvatar,
          ),
          ServiceListTile(
            width: R.sW(context, 115),
            title: 'assets/images/baby_sitting.svg',
            subTitle: 'babySitting'.tr(),
            avatarColor: AppColors.homePinkAvatar,
          ),
        ]),
        SizedBox(
          height: R.sH(context, 10),
        ),
        HomeTextTile(
            onTab: () {
              Navigator.pushNamed(context, Routes.allServices);
            },
            rightText: 'see_all',
            leftText: 'most_special_offers'),
        Padding(
          padding: EdgeInsets.only(
              top: R.sH(context, 10),
              left: R.sW(context, 5),
              right: R.sW(context, 5)),
          child: const Divider(
            color: AppColors.homeDividerColor,
            thickness: 1,
          ),
        ),
        SizedBox(
          height: R.sH(context, 10),
        ),
        SizedBox(
          height: R.sH(context, 10),
        ),
        SizedBox(
          height: R.sH(context, 40),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return OffersItem(
                    title: HomeCubit.get(context).offersList[index],
                    onTap: () {
                      HomeCubit.get(context).changeTabbedOffer(index);
                    });
              }),
        ),
      ],
    );
  }
}
