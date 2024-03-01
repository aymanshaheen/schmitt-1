import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AppPreferences? appPreferences;
  @override
  void initState() {
    HomeCubit.get(context).appStarted();
    appPreferences = sl<AppPreferences>();
    var token = appPreferences!.getData(key: 'token') ?? '';
    getDeviceToken();
    AppConstants.token = (token != '') ? token : '';
    if (AppConstants.token != '') {
      HomeCubit.get(context).showProfile().then((value) => {
            Future.wait([
              HomeCubit.get(context).getSlides("15"),
              HomeCubit.get(context).getServices(1, "15", "0"),
            ])
          });
    }

    super.initState();
  }

  getDeviceToken() async {
    AppConstants.deviceToken = await FirebaseMessaging.instance.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeStates>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 5), () async {
          bool isOnBoardingScreenViewed =
              await appPreferences!.isOnBoardingScreenViewed();
          if (isOnBoardingScreenViewed) {
            if (AppConstants.token != '') {
              Navigator.pushReplacementNamed(
                  context,
                  AppConstants.profile!.email != "customer2@demo.com"
                      ? Routes.home
                      : Routes.homeTech);
            } else {
              Navigator.pushReplacementNamed(context, Routes.login);
            }
          } else {
            Navigator.pushReplacementNamed(context, Routes.onboarding);
          }
        });
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/images/splash_top.svg',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                    ),
                  ),
                ]),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/splash_down.svg',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
