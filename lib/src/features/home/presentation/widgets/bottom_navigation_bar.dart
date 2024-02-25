import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          label: 'Home',
          icon: SvgPicture.asset('assets/images/home.svg'),
        ),
        BottomNavigationBarItem(
          label: 'Bookings',
          icon: SvgPicture.asset('assets/images/booking.svg'),
        ),
        BottomNavigationBarItem(
          label: 'Calender',
          icon: SvgPicture.asset('assets/images/calender.svg'),
        ),
        BottomNavigationBarItem(
          label: 'Inbox',
          icon: SvgPicture.asset('assets/images/inbox.svg'),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: SvgPicture.asset('assets/images/profile.svg'),
        ),
      ],
    );
  }
}
