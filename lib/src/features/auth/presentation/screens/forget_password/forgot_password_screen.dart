import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/error/response_status.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/half_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  int sharedValue = 0;
  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> myTabs = <int, Widget>{
      0: Container(
        margin: EdgeInsets.symmetric(
          horizontal: R.sW(context, 5),
        ),
        child: HalfRounderContainer(
          title: 'email'.tr(),
          containerColor:
              sharedValue != 0 ? AppColors.grey1! : AppColors.darkBlue,
          textColor: AppColors.white,
        ),
      ),
      1: Container(
        margin: EdgeInsets.symmetric(
          horizontal: R.sW(context, 5),
        ),
        child: HalfRounderContainer(
          title: 'phone'.tr(),
          containerColor:
              sharedValue != 1 ? AppColors.grey1! : AppColors.darkBlue,
          textColor: AppColors.white,
        ),
      ),
    };

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
          return forgotBuilder(myTabs);
        },
      ),
    );
  }

  Widget forgotBuilder(Map<int, Widget> myTabs) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: R.sW(context, 20), vertical: R.sH(context, 30)),
        child: Column(
          children: [
            Text(
              "choose_the_way_to_reset_password".tr(),
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.black,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: R.sH(context, 20),
            ),
            CupertinoSegmentedControl<int>(
              children: myTabs,
              pressedColor: AppColors.white,
              onValueChanged: (int val) {
                setState(() {
                  sharedValue = val;
                });
              },
              borderColor: AppColors.white,
              selectedColor: AppColors.white,
              unselectedColor: AppColors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 10), vertical: R.sH(context, 20)),
              groupValue: sharedValue,
            ),
            if (sharedValue == 0)
              CustomTextField(
                isPassword: false,
                prefixIcon: Icons.email,
                controller: _emailController,
                labelText: 'email'.tr(),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            if (sharedValue == 1)
              CustomTextField(
                isPassword: false,
                prefixIcon: Icons.lock,
                controller: _phoneController,
                labelText: 'phone'.tr(),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
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
                textColor: AppColors.white,
                circular: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

 /* void _submitForgotPasswordScreenEmail() {
    if (_emailController.text.isEmpty) {
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
