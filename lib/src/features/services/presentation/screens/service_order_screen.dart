import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/bottom_navigation_bar.dart';
import 'package:schmitt/src/features/services/presentation/widgets/order_content.dart';

class ServiceOrderScreen extends StatelessWidget {
  int currentStep;

  ServiceOrderScreen(
    this.currentStep, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
      listener: (context, state) {
        if (state is StepUpdated) {
          currentStep = state.step;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leadingWidth: R.sW(context, 25),
            elevation: 0,
            title: Text(
              'service_order'.tr(),
              style: TextStyle(
                fontSize: R.F(context, 18),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: R.sW(context, 20), vertical: R.sH(context, 20)),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomStepper(currentStep: currentStep),
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: R.sW(context, 10),
                          vertical: R.sH(context, 20)),
                      child: StepContent(step: currentStep)),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomServiceNavigationBar(
            text1: "back".tr(),
            text2: "next".tr(),
            onTap1: () {
              if (currentStep > 1) {
                ServiceCubit.get(context).updateStep(currentStep - 1);
              } else {
                Navigator.pop(context);
              }
            },
            onTap2: () {
              if (currentStep < 3) {
                if (currentStep == 2 &&
                    ServiceCubit.get(context).selectedDate == null &&
                    ServiceCubit.get(context).selectedHour == null) {
                  buildSnakBar(
                      context: context,
                      message: "please_select_date_and_time_first".tr(),
                      color: AppColors.error);
                }
                else if (currentStep == 1 &&
                    ServiceCubit.get(context).selectedAddressIndex == null) {
                  buildSnakBar(
                      context: context,
                      message: "please_select_address_first".tr(),
                      color: AppColors.error);
                } 
                else {
                  ServiceCubit.get(context).updateStep(currentStep + 1);
                }
              }
              if (currentStep == 3) {
                Navigator.pushNamed(context, Routes.submitOrder);
              }
            },
          ),
        );
      },
    );
  }
}

class CustomStepper extends StatelessWidget {
  final int currentStep;

  const CustomStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep(1, 'location'.tr(), Icons.location_on, context),
        _buildLine(2, context),
        _buildStep(
            2, 'day_and_date'.tr(), Icons.calendar_month_rounded, context),
        _buildLine(3, context),
        _buildStep(3, 'payment'.tr(), Icons.payment, context),
      ],
    );
  }

  Widget _buildStep(
      int step, String title, IconData icon, BuildContext context) {
    return Column(
      children: [
        Container(
          width: R.sW(context, 70),
          height: R.sH(context, 70),
          decoration: BoxDecoration(
            color: step < currentStep
                ? AppColors.darkBlue
                : step == currentStep
                    ? AppColors.white
                    : AppColors.grey1!,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                color:
                    step == currentStep ? AppColors.darkBlue : AppColors.grey1!,
                width: R.sW(context, 1)),
          ),
          child: Icon(
            icon,
            color: step < currentStep
                ? AppColors.white
                : step == currentStep
                    ? AppColors.darkBlue
                    : AppColors.grey,
          ),
        ),
        SizedBox(height: R.sH(context, 10)),
        Text(
          title,
          textWidthBasis: TextWidthBasis.longestLine,
          style: TextStyle(
            fontSize: R.F(context, 14),
            fontWeight: FontWeight.w600,
            color: step == currentStep ? AppColors.darkBlue : AppColors.grey,
          ),
        )
      ],
    );
  }

  Widget _buildLine(int step, BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: R.sH(context, 30)),
        height: 1,
        color: step == currentStep ? AppColors.darkBlue : AppColors.grey,
      ),
    );
  }
}
