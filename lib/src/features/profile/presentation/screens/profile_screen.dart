import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/circular_image.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_listTile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AppPreferences appPreferences = sl<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppConstants.selectedType = appPreferences.getData(key: 'type');
          AppConstants.date = appPreferences.getData(key: 'date') ?? "";
          AppConstants.country =
              appPreferences.getData(key: 'country') ?? AppConstants.country;
          return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  'profile'.tr(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: AppColors.white,
                elevation: 0,
                actions: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
                      child: const MoreInfoIcon()),
                  SizedBox(
                    width: R.sW(context, 15),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Column(children: [
                Container(
                    margin: EdgeInsets.symmetric(vertical: R.sH(context, 10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(children: [
                          CircleAvatar(
                            radius: R.sW(context, 35),
                            child: ClipOval(
                                child: CircularImageBuilder(
                                    photo: AppConstants.profile!.avatar!,
                                    height: R.sW(context, 100),
                                    width: R.sW(context, 100))),
                          ),
                          SizedBox(
                            height: R.sH(context, 10),
                          ),
                          Text(
                            AppConstants.profile!.name!,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: R.sH(context, 5),
                          ),
                          AppConstants.profile!.email == "customer2@demo.com"
                              ? ProfileListTile(
                                  switchModeValue: true,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.orderSetting);
                                  },
                                  isTrailing: true,
                                  icon: AppImage.orders,
                                  title: 'my_orders',
                                )
                              : const SizedBox.shrink(),
                          AppConstants.profile!.email != "customer2@demo.com"
                              ? ProfileListTile(
                                  switchModeValue: true,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.carWash);
                                  },
                                  isTrailing: true,
                                  icon: AppImage.car,
                                  title: 'my_cars',
                                )
                              : const SizedBox.shrink(),
                          AppConstants.profile!.email != "customer2@demo.com"
                              ? ProfileListTile(
                                  switchModeValue: true,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.myAddress);
                                  },
                                  isTrailing: true,
                                  icon: AppImage.car,
                                  title: 'my_places',
                                )
                              : const SizedBox.shrink(),
                          ProfileListTile(
                            switchModeValue: true,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.editProfile);
                            },
                            isTrailing: true,
                            icon: AppImage.profilePhoto,
                            title: 'profile',
                          ),
                          ProfileListTile(
                            switchModeValue: true,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.notificationSettings);
                            },
                            icon: AppImage.notification,
                            title: 'Notifications',
                          ),
                          AppConstants.profile!.email != "customer2@demo.com"
                              ? ProfileListTile(
                                  switchModeValue: true,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.paymentScreen);
                                  },
                                  icon: AppImage.wallet,
                                  title: 'payment',
                                )
                              : const SizedBox.shrink(),
                          ProfileListTile(
                            switchModeValue: true,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.security);
                            },
                            icon: AppImage.security,
                            title: 'security',
                          ),
                          ProfileListTile(
                            switchModeValue: true,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.language);
                            },
                            icon: AppImage.language,
                            title: 'language',
                          ),
                          ProfileListTile(
                            switchModeValue: HomeCubit.get(context).switchValue,
                            onSwitchChanged: (value) {
                              HomeCubit.get(context).changeTheme();
                            },
                            modeSwitch: true,
                            isTrailing: false,
                            icon: AppImage.mode,
                            title: 'dark_mode',
                          ),
                          const ProfileListTile(
                            switchModeValue: true,
                            icon: AppImage.privacy,
                            title: 'privacy_policy',
                          ),
                          const ProfileListTile(
                            switchModeValue: true,
                            icon: AppImage.help,
                            title: 'help_center',
                          ),
                          AppConstants.profile!.email != "customer2@demo.com"
                              ? const ProfileListTile(
                                  switchModeValue: true,
                                  icon: AppImage.help,
                                  title: 'invite_friends',
                                )
                              : const SizedBox.shrink(),
                          ProfileListTile(
                            switchModeValue: true,
                            isLogout: true,
                            isTrailing: false,
                            icon: AppImage.logout,
                            title: 'logout',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: R.sW(context, 10),
                                        vertical: R.sH(context, 10)),
                                    height: R.sH(context, 200),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'logout'.tr(),
                                          style: TextStyle(
                                            color: AppColors.error,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: R.sH(context, 30),
                                        ),
                                        Text(
                                          'are_you_sure_you_want_to_logout'
                                              .tr(),
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: R.sH(context, 30),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                appPreferences.clearAllData();
                                                AppConstants.token = '';
                                                HomeCubit.get(context)
                                                    .currentIndex = 0;
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        Routes.login,
                                                        (route) => false);
                                              },
                                              child: Container(
                                                width: R.sW(context, 140),
                                                height: R.sH(context, 55),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: AppColors.whiteBlue,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'yse_logout'.tr(),
                                                    style: TextStyle(
                                                      color: AppColors.darkBlue,
                                                      fontSize:
                                                          R.F(context, 16),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: R.sW(context, 140),
                                                height: R.sH(context, 55),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: AppColors.darkBlue,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'cancle'.tr(),
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize:
                                                          R.F(context, 16),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ]),
                      ],
                    ))
              ])));
        });
  }
}
