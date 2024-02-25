import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<VerifyCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: false,
          leadingWidth: R.sW(context, 15),
          title: Text(
            'do_you_forgot_password'.tr(),
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
          return forgotBuilder();
        },
      ),
    );
  }

  Widget forgotBuilder() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: R.sW(context, 20), vertical: R.sH(context, 30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "verify_code_has_been_sent_to_your_email".tr(),
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: R.sH(context, 30),
            ),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: R.sH(context, 90),
                fieldWidth: R.sW(context, 70),
                activeFillColor: AppColors.grey1!,
                inactiveFillColor: AppColors.grey1!,
                selectedFillColor: AppColors.grey1,
                activeColor: AppColors.grey1!,
                inactiveColor: AppColors.grey1!,
                selectedColor: AppColors.darkBlue,
              ),
              animationDuration: const Duration(milliseconds: 400),
              enableActiveFill: true,
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "resend_code_in".tr(),
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  width: R.sW(context, 5),
                ),
                Text(
                  "55",
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkBlue,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  width: R.sW(context, 5),
                ),
                Text(
                  "second".tr(),
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.resetPassword);
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

 /* void _submitForgotPasswordScreenEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This email does not have an . Please sign up.'),
        duration: Duration(seconds: 3),
      ),
    );
    return;
  }*/
}
