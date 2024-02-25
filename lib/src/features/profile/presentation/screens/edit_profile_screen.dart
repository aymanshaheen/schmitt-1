import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/edit_profile_text_field.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:country_picker/country_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController phoneController;
  late final TextEditingController dateController;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  final AppPreferences appPreferences = sl<AppPreferences>();
  List<String> gender = [
    'male',
    'female',
  ];
  String? selectedGender;
  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: AppConstants.profile!.phone);
    dateController = TextEditingController(text: AppConstants.date);
    nameController = TextEditingController(text: AppConstants.profile!.name);
    emailController = TextEditingController(text: AppConstants.profile!.email);
    selectedGender = AppConstants.selectedType;
    if (!gender.contains(selectedGender)) {
      selectedGender = 'male';
    }
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        appBar: profileAppBar(
          context: context,
          title: 'ُedit_profile',
          isAction: false,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is UpdateProfileLoaded) {
              HomeCubit.get(context).showProfile();
            }
            if (state is UpdateProfileErorr) {
              buildSnakBar(
                  color: AppColors.error,
                  context: context,
                  message: state.message.toString());
            }
            if (state is ShowProfileLoaded) {
              buildSnakBar(
                  color: AppColors.green,
                  context: context,
                  message: 'profile_updated_successfully'.tr());
            }
          },
          builder: (context, state) {
            if (state is ShowProfileLoding) {
              return Center(
                child: CircularIndicator(
                  color: AppColors.darkBlue,
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  EditProfileField(
                    hintText: 'name',
                    controller: nameController,
                  ),
                  Stack(
                    children: [
                      EditProfileField(
                        controller: dateController,
                        hintText: 'ُdate_of_birth',
                      ),
                      Positioned(
                        top: R.sH(context, 30),
                        left: EasyLocalization.of(context)!
                                    .currentLocale
                                    ?.languageCode ==
                                'ar'
                            ? R.sW(context, 35)
                            : R.sW(context, 310),
                        child: GestureDetector(
                          onTap: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              AppConstants.date =
                                  '${value!.day}/${value.month}/${value.year}';
                              dateController.text = AppConstants.date;
                            });
                          },
                          child: SizedBox(
                            width: R.sW(context, 20),
                            height: R.sH(context, 20),
                            child: SvgPicture.asset(
                              AppImage.calendarBar,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  EditProfileField(
                    hintText: 'email',
                    isTextFieldEnabled: false,
                    controller: emailController,
                  ),
                  GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        countryListTheme: CountryListThemeData(
                          flagSize: 28,
                          backgroundColor: AppColors.white,
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: R.F(context, 18),
                          ),
                        ),
                        favorite: [
                          'US',
                          'EG',
                          'AE',
                          'SA',
                          'KW',
                          'QA',
                          'OM',
                          'BH',
                          'JO',
                          'LB',
                          'SY',
                          'IQ',
                          'PS',
                          'YE',
                          'IR',
                          'TR'
                        ],
                        onSelect: (Country country) {
                          setState(() {
                            AppConstants.country = country.name;
                          });
                        },
                      );
                    },
                    child: Container(
                      width: R.sW(context, R.W(context) - 20),
                      height: R.sH(context, 60),
                      decoration: BoxDecoration(
                        color: AppColors.editProfileTextFieldColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 20),
                        vertical: R.sH(context, 10),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppConstants.country,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: R.F(context, 16),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  EditProfileField(
                    hintText: 'phone',
                    controller: phoneController,
                    isTextFieldEnabled: false,
                    isPhoneNumber: true,
                  ),
                  Container(
                    width: R.sW(context, R.W(context) - 10),
                    height: R.sH(context, 60),
                    margin: EdgeInsets.symmetric(
                      horizontal: R.sW(context, 20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: R.sW(context, 10),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.editProfileTextFieldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedGender,
                          items: gender.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items.tr()),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedGender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: R.sW(context, R.W(context) - 40),
                    margin: EdgeInsets.symmetric(
                      horizontal: R.sW(context, 20),
                      vertical: R.sH(context, 30),
                    ),
                    child: CustomLoginButton(
                      text: 'update_profile'.tr(),
                      isLoading: state is UpdateProfileLoading,
                      onPressed: () {
                        appPreferences.saveData(
                          key: 'type',
                          value: selectedGender!.tr(),
                        );
                        AppConstants.selectedType = selectedGender;
                        appPreferences.saveData(
                            key: 'date', value: dateController.text);
                        AppConstants.date = dateController.text;
                        appPreferences.saveData(
                            key: 'country', value: AppConstants.country);
                        AppConstants.profile!.name != nameController.text;
                        HomeCubit.get(context).updateProfile(SignUpParams(
                          name: nameController.text,
                          email: AppConstants.profile!.email!,
                          type: AppConstants.profile!.type!,
                          area: AppConstants.country,
                          phoneCode: 'eg',
                          phone: AppConstants.profile!.phone,
                        ));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
