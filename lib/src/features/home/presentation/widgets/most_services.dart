import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/home_text_tile.dart';
import 'package:schmitt/src/features/home/presentation/widgets/offers_home_listview_item.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MostServices extends StatefulWidget {
  const MostServices({
    Key? key,
  }) : super(key: key);

  @override
  _MostServicesState createState() => _MostServicesState();
}

class _MostServicesState extends State<MostServices>
    with TickerProviderStateMixin {
  num numberItems = 1;

  @override
  Widget build(BuildContext context) {
    List<Function> functionList = [
      () => HomeCubit.get(context).getServices(1, AppStrings.allId),
      () => HomeCubit.get(context).getServices(1, AppStrings.houseId),
      () => HomeCubit.get(context).getServices(1, AppStrings.carId),
      () => HomeCubit.get(context).getServices(1, AppStrings.babyId),
    ];
    return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
      if (state is ServicesLoaded) {
        numberItems = state.services!.length;
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: R.sW(context, 10)),
            child: HomeTextTile(
                onTab: () {
                  Navigator.pushNamed(
                    context,
                    Routes.serviceType,
                    arguments: ServiceArguments('0', 'services'.tr()),
                  );
                },
                rightText: 'see_all',
                leftText: 'most_special_offers'),
          ),
          SizedBox(
            height: R.sH(context, 20),
          ),
          Container(
            height: R.sH(context, 40),
            padding: EdgeInsets.symmetric(horizontal: R.sW(context, 10)),
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
                        functionList[index]();
                      });
                }),
          ),
          if (state is ServicesLoading)
            SizedBox(
              height: R.sH(context, 120 * numberItems.toDouble()),
              child: Center(
                child: CircularIndicator(
                  color: AppColors.darkBlue,
                ),
              ),
            ),
          if (state is ServicesError)
            const Center(
              child: Text('Error loading services'),
            ),
          if (HomeCubit.get(context).services.isNotEmpty &&
              state is! ServicesLoading)
            Container(
              color: AppColors.grey.withOpacity(0.05),
              child: ListView.builder(
                itemCount: HomeCubit.get(context).services.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      verticalOffset: -20,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.service,
                              arguments:
                                  HomeCubit.get(context).services[index]),
                          child: ServiceItem(
                            services: HomeCubit.get(context).services[index],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          if (HomeCubit.get(context).services.isEmpty)
            NoDataAvailable(
                text: "there_is_no_services_available_at_the_moment".tr()),
        ],
      );
    });
  }
}
