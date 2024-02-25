import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_button.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_divider_row.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/sign_in_custom_row.dart';

class StartedLogin extends StatelessWidget {
  const StartedLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(R.sW(context, 20)),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: R.sH(context, 340),
              child: SvgPicture.asset(
                "assets/images/login_logo.svg",
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'get_started'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: R.F(context, 26),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: R.sH(context, 30)),
                  Container(
                    height: R.sH(context, 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.grey1!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: SvgPicture.asset('assets/images/facebook.svg'),
                        ),
                        SizedBox(width: R.sW(context, 15)),
                        Text(
                          'sign_in_with_facebook'.tr(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: R.F(context, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: R.sH(context, 15)),
                  Container(
                    height: R.sH(context, 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.grey1!,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            child: SvgPicture.asset(AppImage.google,
                                fit: BoxFit.contain),
                          ),
                          SizedBox(width: R.sW(context, 15)),
                          Text(
                            'sign_in_with_Google'.tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: R.F(context, 16),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: R.sH(context, 15)),
                  Container(
                    height: R.sH(context, 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.grey1!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20.0,
                          child: SvgPicture.asset(AppImage.apple,
                              fit: BoxFit.contain),
                        ),
                        SizedBox(width: R.sW(context, 15)),
                        Text(
                          'sign_in_with_apple'.tr(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: R.F(context, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: R.sH(context, 20)),
                  CustomDivider(text: 'or'.tr()),
                  SizedBox(height: R.sH(context, 25)),
                  CustomButton(
                    text: 'sign_in_with_password'.tr(),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.login);
                    },
                  ),
                  SizedBox(height: R.sH(context, 35)),
                  CustomRow(
                    text1: 'dont_have_account'.tr(),
                    text2: 'sign_up'.tr(),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.signup);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
