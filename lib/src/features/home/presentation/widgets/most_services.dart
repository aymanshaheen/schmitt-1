import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/home/presentation/widgets/home_text_tile.dart';
import 'package:schmitt/src/features/home/presentation/widgets/offers_home_listview_item.dart';
import 'package:schmitt/src/features/home/presentation/widgets/service_item.dart';

class MostServices extends StatefulWidget {
  const MostServices({super.key});

  @override
  _MostServicesState createState() => _MostServicesState();
}

class _MostServicesState extends State<MostServices> {
  @override
  Widget build(BuildContext context) {
    List<Function> functionList = [
      () => HomeCubit.get(context)
          .getServices(1, AppConstants.addressID, AppStrings.allId),
      () => HomeCubit.get(context)
          .getServices(1, AppConstants.addressID, AppStrings.houseId),
      () => HomeCubit.get(context)
          .getServices(1, AppConstants.addressID, AppStrings.carId),
      () => HomeCubit.get(context)
          .getServices(1, AppConstants.addressID, AppStrings.babyId),
    ];
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                  height: R.sH(context, 100),
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
              if (HomeCubit.get(context).services!.isNotEmpty &&
                  state is! ServicesLoading)
                Container(
                  color: AppColors.grey.withOpacity(0.05),
                  child: ListView.builder(
                    itemCount: HomeCubit.get(context).services!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.service,
                              arguments:
                                  HomeCubit.get(context).services![index]),
                          child: ServiceItem(
                            services: HomeCubit.get(context).services![index],
                          ));
                    },
                  ),
                ),
              if (HomeCubit.get(context).services!.isEmpty)
                Container(
                  child: const Center(
                    child: Text('there is no services available at the moment'),
                  ),
                ),
            ],
          );
        });
  }
}
