import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_up_usecase.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_divider_row.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_container.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_remember_me.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/sign_in_custom_row.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpScreen> {
  bool _rememberMe = false;
  String phoneCode = '';
  String phoneCountryCode = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AppPreferences? appPreferences;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialFailure &&
              credentialState.message ==
                  DataSource.networkConnectError.getFailure().message) {
            buildSnakBar(
                context: context,
                message: credentialState.message,
                color: AppColors.error);
          }
          if (credentialState is CredentialSuccess) {
            if (credentialState.user.message == '') {
              AppConstants.profile = credentialState.user;
              appPreferences?.saveData(
                  key: 'token', value: credentialState.user.token);
              AppConstants.token = credentialState.user.token!;
              Navigator.pushReplacementNamed(context, Routes.home);
            } else {
              buildSnakBar(
                  context: context,
                  message: credentialState.user.message!,
                  color: AppColors.error);
            }
          } else if (credentialState is CredentialGoogleSuccess) {
            appPreferences?.saveData(key: 'token', value: AppConstants.token);
            HomeCubit.get(context).showProfile();
            Navigator.pushReplacementNamed(context, Routes.home);
          }
          if (credentialState is CredentialFailure) {
            buildSnakBar(
                context: context,
                message: credentialState.message,
                color: AppColors.error);
          }
        },
        builder: (context, credentialState) {
          return signUpWidget();
        },
      ),
    );
  }

  signUpWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: R.sH(context, 185),
            child: Image.asset(
              height: R.sH(context, 100),
              width: R.sW(context, 100),
              "assets/images/original_logo.png",
            ),
          ),
          Padding(
            padding: EdgeInsets.all(R.sW(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'create_your_account'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: R.F(context, 26),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: R.sH(context, 20)),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        isPassword: false,
                        labelText: 'name'.tr(),
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          String p = r'^[a-zA-Z\s]*$';
                          RegExp regExp = RegExp(p);
                          if (regExp.hasMatch(value)) {
                            return null;
                          }
                          return 'Please enter a valid name';
                        },
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: R.sH(context, 15)),
                      IntlPhoneField(
                        controller: _phoneController,
                        initialCountryCode: 'AE',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            labelText: 'phone'.tr(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(Icons.person,
                                color: AppColors.grey, size: 20),
                            fillColor: Colors.grey[200],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.darkBlue,
                              ),
                            )),
                        keyboardType: TextInputType.phone,
                        onChanged: (phone) {
                          phoneCode = phone.countryCode;
                          phoneCountryCode = phone.countryISOCode;
                        },
                        validator: (PhoneNumber? value) {
                          if (value == null || value.completeNumber.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (!RegExp(r'^[0-9]+$')
                              .hasMatch(value.completeNumber)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        isPassword: false,
                        labelText: 'email'.tr(),
                        prefixIcon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          String p =
                              "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                          RegExp regExp = RegExp(p);
                          if (regExp.hasMatch(value)) {
                            return null;
                          }
                          return 'Please enter a valid email';
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: R.sH(context, 15)),
                      CustomTextField(
                        labelText: 'password_hint'.tr(),
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }

                          return null;
                        },
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: R.sH(context, 15)),
                      CustomTextField(
                        labelText: 'confirm_password_hint'.tr(),
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password again';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }

                          return null;
                        },
                        controller: _repasswordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: R.sH(context, 10)),
                CustomCheckbox(
                  value: _rememberMe,
                  onChanged: (bool value) {
                    setState(() {
                      _rememberMe = value;
                    });
                  },
                ),
                SizedBox(height: R.sH(context, 15)),
                Align(
                  alignment: Alignment.center,
                  child: BlocBuilder<CredentialCubit, CredentialState>(
                    builder: (context, credentialState) {
                      return CustomLoginButton(
                        text: "sign_up".tr(),
                        onPressed: _submitSignUp,
                        isLoading: credentialState is CredentialLoading,
                      );
                    },
                  ),
                ),
                SizedBox(height: R.sH(context, 30)),
                CustomDivider(text: "or_continue_with".tr()),
                SizedBox(height: R.sH(context, 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomInkWell(
                      onTap: () {
                        BlocProvider.of<CredentialCubit>(context)
                            .facebookAuthSubmit();
                      },
                      imagePath: AppImage.facebook,
                    ),
                    CustomInkWell(
                      onTap: () {
                        BlocProvider.of<CredentialCubit>(context)
                            .googleAuthSubmit();
                      },
                      imagePath: AppImage.google,
                    ),
                    CustomInkWell(
                      onTap: () {},
                      imagePath: AppImage.apple,
                    ),
                  ],
                ),
                SizedBox(height: R.sH(context, 20)),
                CustomRow(
                  text1: 'have_account'.tr(),
                  text2: 'sign_in'.tr(),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitSignUp() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _repasswordController.text) {
        buildSnakBar(
            context: context,
            message: 'password_and_confirm_password_not_match'.tr(),
            color: AppColors.error);
        return;
      }
      BlocProvider.of<CredentialCubit>(context).signUpSubmit(SignUpParams(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: (phoneCode.characters.last + _phoneController.text).toString(),
        area: "",
        city: "",
        passwordConfirm: _repasswordController.text,
        phoneCode: phoneCountryCode.toLowerCase(),
        type: '',
      ));
    }
  }
}
