import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/payment_container.dart';
import 'package:schmitt/src/features/services/presentation/widgets/service_order.dart';
import 'package:schmitt/src/features/services/presentation/widgets/submit_custom_row.dart';
import 'package:schmitt/src/features/services/presentation/widgets/submit_order_container.dart';

class SubmitOrderScreen extends StatelessWidget {
  const SubmitOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
                  ServiceOrder(),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
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
                    text1: 'date'.tr(),
                    text2: '12/12/2021',
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
                    text1: 'date'.tr(),
                    text2: '12/12/2021',
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
                    label: 'houskeeping',
                    value: '1000 \$',
                    color: AppColors.black,
                  ),
                  CustomRow(
                    label: 'transport',
                    value: '50 \$',
                    color: AppColors.darkBlue,
                  ),
                  CustomRow(
                    label: 'promo',
                    value: '50 \$',
                    color: AppColors.green,
                  ),
                  CustomRow(
                    label: 'tax',
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
                    label: 'total',
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
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.orderService, arguments: 2);
              },
              child: FullRounderContainer(
                title: 'sure_pay'.tr(),
                containerColor: AppColors.darkBlue,
                textColor: AppColors.white,                circular: 30,

              ),
            ),
          ),
        );
      },
    );
  }
}
