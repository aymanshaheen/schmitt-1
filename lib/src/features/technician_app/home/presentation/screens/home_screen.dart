import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/screens/home_layout.dart';

class HomeTechScreen extends StatefulWidget {
  const HomeTechScreen({super.key});

  @override
  State<HomeTechScreen> createState() => _HomeTechScreenState();
}

class _HomeTechScreenState extends State<HomeTechScreen> {
  List<Widget> screens = [
    const HomeTechLayoutScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ShowProfileLoding) {
          return const Center(
            child: CircularIndicator(
              color: AppColors.homeBlueColor,
            ),
          );
        }
        return Scaffold(
            body: screens[HomeCubit.get(context).currentIndex],
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
                  label: 'profile'.tr(),
                  icon: SvgPicture.asset('assets/images/profile.svg'),
                ),
              ],
            ));
      },
    );
  }
}
