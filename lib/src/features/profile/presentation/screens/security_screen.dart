import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/notifications_settings_component.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/security_custom_button.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({
    super.key,
  });

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool rememberMe = true;
  bool faceId = false;
  bool biometricID = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar(
          title: 'Security',
          context: context,
          isAction: true,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        body: Column(
          children: [
            NotificationsSettingsComponent(
                title: 'Remember me',
                switchValue: rememberMe,
                onChange: (value) {
                  setState(() {
                    rememberMe = value;
                  });
                }),
            NotificationsSettingsComponent(
                title: 'Face ID',
                switchValue: faceId,
                onChange: (value) {
                  setState(() {
                    faceId = value;
                  });
                }),
            NotificationsSettingsComponent(
                title: 'Biometric ID',
                switchValue: biometricID,
                onChange: (value) {
                  setState(() {
                    biometricID = value;
                  });
                }),
            Padding(
              padding: EdgeInsets.only(
                  left: R.sW(context, 10),
                  right: R.sW(context, 20),
                  top: R.sH(context, 10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Google Authenticator',
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      height: 0.08,
                      letterSpacing: 0.20,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,
                      color: AppColors.black, size: R.F(context, 20))
                ],
              ),
            ),
            SizedBox(
              height: R.sH(context, 30),
            ),
            CustomSecurityButton(text: 'Change PIN', onPressed: () {}),
            SizedBox(
              height: R.sH(context, 10),
            ),
            CustomSecurityButton(text: 'Change Password', onPressed: () {})
          ],
        ));
  }
}
