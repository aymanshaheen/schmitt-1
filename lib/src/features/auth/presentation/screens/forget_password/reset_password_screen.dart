import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _repasswordController.dispose();
    super.dispose();
  }

  int sharedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: false,
          leadingWidth: R.sW(context, 15),
          title: Text(
            'set_new_password'.tr(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
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
            if (credentialState.user.message == "") {
              Navigator.pushReplacementNamed(context, Routes.home);
            } else {
              buildSnakBar(
                  context: context,
                  message: credentialState.user.message!,
                  color: AppColors.error);
            }
          }
          if (credentialState is CredentialFailure) {
            buildSnakBar(
                context: context,
                message: credentialState.message,
                color: AppColors.error);
          }
        },
        builder: (context, credentialState) {
          return resetBuilder();
        },
      ),
    );
  }

  Widget resetBuilder() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: R.sW(context, 20), vertical: R.sH(context, 30)),
        child: Column(
          children: [
            Text(
              "set_your_new_password".tr(),
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontStyle: FontStyle.italic),
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
              controller: _repasswordController,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            SizedBox(
              height: R.sH(context, 40),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.verifyCode);
              },
              child: FullRounderContainer(
                title: 'continue'.tr(),
                containerColor: AppColors.darkBlue,
                textColor: AppColors.white,                circular: 30,

              ),
            ),
          ],
        ),
      ),
    );
  }

 /* void _submitResetPasswordScreenEmail() {
    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('This email does not have an . Please sign up.'),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }
  }*/
}
