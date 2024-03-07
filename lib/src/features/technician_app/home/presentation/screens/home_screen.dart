import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/exit_bottom_sheet.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';

class HomeTechScreen extends StatefulWidget {
  const HomeTechScreen({super.key});

  @override
  State<HomeTechScreen> createState() => _HomeTechScreenState();
}

class _HomeTechScreenState extends State<HomeTechScreen> {
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
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
            final shouldClose = await showModalBottomSheet(
                context: context,
                builder: (context) => const ExitBottomSheet());

            return shouldClose ?? false;
          },
          child: Scaffold(
              body: TechCubit.get(context)
                  .screens[HomeCubit.get(context).currentIndex],
              bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: R.sW(context, 10)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
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
                      label: "my_orders".tr(),
                      icon: SvgPicture.asset(
                        AppImage.orders,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
