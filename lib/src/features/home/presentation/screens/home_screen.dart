import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/exit_bottom_sheet.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:schmitt/src/core/usecase/address_params.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    AppConstants.myPlace =
        "${place.country} ${place.administrativeArea} ${place.subAdministrativeArea}";
    appPreferences?.saveData(key: "myPlace", value: AppConstants.myPlace);
    await ServiceCubit.get(context).createAddress(AddressParams(
        address: AppConstants.myPlace,
        name: "Home",
        locationLatitude: position.latitude.toString(),
        locatiogLongitude: position.longitude.toString()));
  }

  @override
  void initState() {
    if (AppConstants.addressID == "") {
      getCurrentLocation();
    }
    super.initState();
  }

  AppPreferences? appPreferences;

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
      child:
          BlocConsumer<ServiceCubit, ServiceStates>(listener: (context, state) {
        if (state is CreateAddressLoaded) {
          AppConstants.addressID =
              ServiceCubit.get(context).address!.id.toString();
          appPreferences?.saveData(
              key: "addressId", value: AppConstants.addressID);
          Future.wait([
            HomeCubit.get(context).getSlides(),
            HomeCubit.get(context).getServices(1, AppStrings.allId),
          ]);
        }
      }, builder: (context, state) {
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: HomeCubit.get(context).slides.isEmpty ||
                      HomeCubit.get(context).services.isEmpty
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
      }),
    );
  }
}
