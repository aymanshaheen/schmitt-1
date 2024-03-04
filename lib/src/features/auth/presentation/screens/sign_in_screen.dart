import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/auth/domain/usercases/sign_in_usecase.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_divider_row.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_container.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_remember_me.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/sign_in_custom_row.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInScreen> {
  bool isPassword = false;
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AppPreferences? appPreferences;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    appPreferences = sl<AppPreferences>();
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
              AppConstants.profile!.localedType != "مزود الخدمة"
                  ? Future.wait([
                      HomeCubit.get(context).getSlides("15"),
                      HomeCubit.get(context).getServices(1, "15", "0"),
                    ])
                  : TechCubit.get(context)
                      .getOrders(AppStrings.technicianAssigned);

              Navigator.pushReplacementNamed(
                  context,
                  AppConstants.profile!.localedType != "مزود الخدمة"
                      ? Routes.home
                      : Routes.homeTech);
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
          return loginBuilder();
        },
      ),
    );
  }

  Widget loginBuilder() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: R.sH(context, 260),
            child: Image.asset(
              "assets/images/original_logo.png",
            ),
          ),
          Padding(
            padding: EdgeInsets.all(R.sW(context, 16)),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login_to_your_account'.tr(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: R.F(context, 26),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: R.sH(context, 25)),
                      CustomTextField(
                        labelText: 'email'.tr(),
                        isPassword: false,
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
                          return null;
                        },
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
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
                  SizedBox(height: R.sH(context, 20)),
                  BlocBuilder<CredentialCubit, CredentialState>(
                    builder: (context, credentialState) {
                      return CustomLoginButton(
                        text: "sign_in".tr(),
                        onPressed: _submitLogin,
                        isLoading: credentialState is CredentialLoading,
                      );
                    },
                  ),
                  SizedBox(height: R.sH(context, 20)),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgetPassword);
                      },
                      child: Text(
                        'forget_the_password'.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: R.sH(context, 20)),
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
                  SizedBox(height: R.sH(context, 30)),
                  CustomRow(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.signup);
                    },
                    text1: 'dont_have_account'.tr(),
                    text2: 'sign_up'.tr(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitLogin() async {
    if (formKey.currentState!.validate()) {
      await BlocProvider.of<CredentialCubit>(context).signInSubmit(SignInParams(
          email: _emailController.text, password: _passwordController.text));
    }
  }
}
