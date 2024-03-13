import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/add_car_bottom_sheet.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/bottom_sheet_custom.dart';
import 'package:schmitt/src/features/services/domain/entities/car.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';

class CarItem extends StatefulWidget {
  final CarDataEntity services;
  const CarItem({super.key, required this.services});

  @override
  State<CarItem> createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: R.sH(context, 5),
        horizontal: R.sW(context, 15),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(R.sW(context, 15)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: R.sW(context, 50),
                  height: R.sH(context, 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SvgPicture.asset(
                      AppImage.car,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: R.sW(context, 10),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    height: R.sH(context, 5),
                  ),
                  Text(
                    widget.services.name!,
                    style: TextStyle(
                      color: AppColors.homeBlackColor,
                      fontSize: R.F(context, 14),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Text(
                    widget.services.plate!,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: R.F(context, 12),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      height: R.sH(context, 15),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            ServiceCubit.get(context).car = null;
                            AppConstants.selectEdit = widget.services.id!;
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: const MyBottomSheet(
                                  isEdit: true,
                                ),
                              ),
                            );
                          },
                          child: SvgPicture.asset(AppImage.edit,
                              fit: BoxFit.cover,
                              width: R.sW(context, 25),
                              height: R.sH(context, 25)),
                        ),
                        SizedBox(
                          width: R.sW(context, 15),
                        ),
                        InkWell(
                          onTap: () {
                            ServiceCubit.get(context).car = null;
                            AppConstants.selectEdit = widget.services.id!;
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const DeleteCarBottomSheet(
                                  isCar: false,
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.delete_outline,
                            color: AppColors.error,
                            size: R.sW(context, 25),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            InkWell(
              onTap: () {
                AppConstants.currentCar = widget.services;
                Navigator.pushNamed(
                  context,
                  Routes.serviceType,
                  arguments: ServiceArguments("3", 'carWash'.tr()),
                );
              },
              child: FullRounderContainer(
                  title: "order_service_for_it".tr(),
                  containerColor: AppColors.white,
                  textColor: AppColors.darkBlue,
                  circular: 10),
            )
          ],
        ),
      ),
    );
  }
}
