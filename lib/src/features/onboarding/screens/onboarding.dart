import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/widgets/exit_bottom_sheet.dart';
import 'package:schmitt/src/features/onboarding/bloc/onboarding_cubit.dart';
import 'package:schmitt/src/features/onboarding/bloc/onboarding_event.dart';
import 'package:schmitt/src/features/onboarding/bloc/onboarding_state.dart';
import 'package:schmitt/src/features/onboarding/screens/onboarding_container.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController(initialPage: 0);

  final AppPreferences _appPreferences = sl<AppPreferences>();
  @override
  void initState() {
    super.initState();
    _appPreferences.setOnBoardingScreenViewed();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final shouldClose = await showModalBottomSheet(
            context: context, builder: (context) => const ExitBottomSheet());

        return shouldClose ?? false;
      },
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingStates>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: controller,
                  onPageChanged: (value) {
                    state.pageIndex = value;
                    BlocProvider.of<OnboardingBloc>(context)
                        .add(OnboardingEvents());
                  },
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return OnboardingPage(
                        imageUrl: AppImage.carCleaning,
                        pageIndex: 0,
                        preRichText: "on_boarding_preRichText".tr(),
                        desc: "on_boarding_desc1".tr(),
                        desc2: "on_boarding_desc12".tr(),
                        containerColor: AppColors.onBoardingFirstPageColor,
                        buttonColor: AppColors.onBoardingFirstButtonColor,
                        richTextColor: AppColors.onBoardingFirstButtonColor,
                        originalTextColor:
                            AppColors.onBoardingFirstPageOriginalTextColor,
                        controller: controller,
                      );
                    } else if (index == 1) {
                      return OnboardingPage(
                        imageUrl: AppImage.vaccumCleaner,
                        pageIndex: 1,
                        desc: "on_boarding_desc2".tr(),
                        desc2: "on_boarding_desc22".tr(),
                        containerColor: AppColors.whiteBlue,
                        buttonColor: AppColors.lightBlue,
                        richTextColor: AppColors.black,
                        originalTextColor: AppColors.lightBlue,
                        controller: controller,
                      );
                    } else {
                      return OnboardingPage(
                        imageUrl: AppImage.babyStroller,
                        pageIndex: 2,
                        desc: "on_boarding_desc3".tr(),
                        desc2: "on_boarding_desc32".tr(),
                        containerColor: AppColors.lightPurble.withOpacity(0.5),
                        buttonColor: AppColors.lightPurble,
                        richTextColor: AppColors.lightPurble,
                        originalTextColor: AppColors.black,
                        controller: controller,
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
