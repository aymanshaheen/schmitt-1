import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/services/domain/usercases/create_order_use_case.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/payment_container.dart';
import 'package:schmitt/src/features/services/presentation/widgets/service_order.dart';
import 'package:schmitt/src/features/services/presentation/widgets/submit_custom_row.dart';
import 'package:schmitt/src/features/services/presentation/widgets/submit_order_container.dart';

class SubmitOrderScreen extends StatelessWidget {
  const SubmitOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> createOrder() async {
      ServiceCubit.get(context).createOrder(
          OrderParams(
            name: AppConstants.service!.title,
            price: AppConstants.service!.category!.id == 3
                ? ServiceCubit.get(context).carWashPrice
                : AppConstants.service!.category!.id == 2
                    ? ServiceCubit.get(context).calculateTotalPrice()
                    : ServiceCubit.get(context).numberOfChilds * 20,
            addressId: AppConstants.addressId,
            carId: AppConstants.service!.category!.id == 3
                ? AppConstants.currentCar!.id
                : null,
            services: [
              ServiceParams(
                id: AppConstants.service!.id,
                inCartCount: 1,
              )
            ],
            microServices: const [],
          ),
          AppConstants.addressID);
    }

    return BlocConsumer<ServiceCubit, ServiceStates>(
      listener: (context, state) {
        if (state is CreateOrderLoaded) {
          // Navigator.pushNamed(context, Routes.home);
        }
      },
      builder: (context, state) {
        ServiceCubit service = ServiceCubit.get(context);
        String dayName =
            EasyLocalization.of(context)!.currentLocale!.languageCode == "en"
                ? DateFormat('EEEE').format(service.selectedDate)
                : DateFormat('EEEE', 'ar_SA').format(service.selectedDate);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: R.sW(context, 25),
            elevation: 0,
            title: Text(
              'sure_order'.tr(),
              style: TextStyle(
                fontSize: R.F(context, 18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: R.sW(context, 20), vertical: R.sH(context, 10)),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConstants.service!.category!.id == 2
                      ? const ServiceOrder()
                      : const SizedBox.shrink(),
                  AppConstants.service!.category!.id == 2
                      ? SizedBox(
                          height: R.sH(context, 20),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    'date'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  CustomContainer(
                    icon: Icons.calendar_month_sharp,
                    text1: dayName,
                    text2: service.selectedDate.toString().split(' ')[0],
                    onTap: () {
                      Navigator.pushNamed(context, Routes.orderService,
                          arguments: 2);
                    },
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  CustomContainer(
                    icon: Icons.calendar_month_sharp,
                    text1: 'clock'.tr(),
                    text2: service.selectedHour.toString() + ':00',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.orderService,
                          arguments: 2);
                    },
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  Text(
                    'payment_method'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  const PaymentContainer(),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  Text(
                    'enter_the_promo_code'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 20),
                        vertical: R.sH(context, 20)),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.darkBlue,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "X",
                          style: TextStyle(
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                        SizedBox(
                          width: R.sW(context, 5),
                        ),
                        Text(
                          "apply".tr(),
                          style: TextStyle(
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey1,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          AppImage.edit,
                          color: AppColors.darkBlue,
                        ),
                        SizedBox(
                          width: R.sW(context, 5),
                        ),
                        Text(
                          'edit'.tr(),
                          style: TextStyle(
                            fontSize: R.F(context, 16),
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  Text(
                    'recipt'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  CustomRow(
                    label: AppConstants.service!.title,
                    value: AppConstants.service!.category!.id == 3
                        ? ServiceCubit.get(context).carWashPrice.toString() +
                            " \$"
                        : AppConstants.service!.category!.id == 2
                            ? ServiceCubit.get(context)
                                    .calculateTotalPrice()
                                    .toString() +
                                " \$"
                            : (ServiceCubit.get(context).numberOfChilds * 20)
                                    .toString() +
                                " \$",
                    color: AppColors.black,
                  ),
                  CustomRow(
                    label: 'transport'.tr(),
                    value: '50 \$',
                    color: AppColors.darkBlue,
                  ),
                  CustomRow(
                    label: 'promo'.tr(),
                    value: '50 \$',
                    color: AppColors.green,
                  ),
                  CustomRow(
                    label: 'tax'.tr(),
                    value: '100 \$',
                    color: AppColors.black,
                  ),
                  Divider(
                    color: AppColors.grey1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  CustomRow(
                    label: 'total'.tr(),
                    value: '800 \$',
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 20), vertical: R.sH(context, 10)),
              height: R.sH(context, 70),
              color: AppColors.white,
              child: CustomLoginButton(
                text: "sure_pay".tr(),
                onPressed: createOrder,
                isLoading: state is CreateOrderLoading,
              )),
        );
      },
    );
  }
}
