import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: HomeCubit.get(context).slides.isEmpty ||
                  HomeCubit.get(context).services!.isEmpty
              ? Center(
                  child: CircularIndicator(
                    color: AppColors.darkBlue,
                  ),
                )
              : HomeCubit.get(context)
                  .screens[HomeCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.homeBlueColor,
            unselectedItemColor: AppColors.homeGreyColor,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (value) {
              HomeCubit.get(context).changeBottomNavBar(value);
            },
            items: [
              BottomNavigationBarItem(
                label: "home".tr(),
                icon: SvgPicture.asset('assets/images/home.svg'),
              ),
              BottomNavigationBarItem(
                label: 'bookings'.tr(),
                icon: SvgPicture.asset('assets/images/booking.svg'),
              ),
              BottomNavigationBarItem(
                label: 'calendar'.tr(),
                icon: SvgPicture.asset(AppImage.calendarBar),
              ),
              BottomNavigationBarItem(
                label: 'inbox'.tr(),
                icon: SvgPicture.asset('assets/images/inbox.svg'),
              ),
              BottomNavigationBarItem(
                label: 'profile'.tr(),
                icon: SvgPicture.asset('assets/images/profile.svg'),
              ),
            ],
          ),
        );
      },
    );
  }
}
