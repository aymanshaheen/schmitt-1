import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/custom_tab_bar.dart';
import 'package:schmitt/src/features/home/presentation/widgets/home_text_tile.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_list_tile_widget.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SlidesLoading) {
          return Center(
            child: CircularIndicator(
              color: AppColors.darkBlue,
            ),
          );
        }
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
              slides: HomeCubit.get(context).slides,
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.serviceType,
                    arguments: ServiceArguments('2', 'housekeepings'.tr()),
                  );
                },
                child: ServiceListTile(
                  width: R.sW(context, 115),
                  title: 'assets/images/cleaning.svg',
                  subTitle: 'housekeepings'.tr(),
                  avatarColor: AppColors.homeGreenAvatar,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.serviceType,
                    arguments: ServiceArguments("3", 'carWash'.tr()),
                  );
                },
                child: ServiceListTile(
                  title: 'assets/images/car.svg',
                  subTitle: 'carWash'.tr(),
                  width: R.sW(context, 115),
                  avatarColor: AppColors.homeGreyAvatar,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.serviceType,
                    arguments: ServiceArguments("4", 'babySitting'.tr()),
                  );
                },
                child: ServiceListTile(
                  width: R.sW(context, 115),
                  title: 'assets/images/baby_sitting.svg',
                  subTitle: 'babySitting'.tr(),
                  avatarColor: AppColors.homePinkAvatar,
                ),
              ),
            ]),
            SizedBox(
              height: R.sH(context, 10),
            ),
          ],
        );
      },
    );
  }
}
