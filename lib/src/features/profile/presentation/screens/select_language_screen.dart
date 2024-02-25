import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:schmitt/src/container_injector.dart';
import 'package:schmitt/src/core/network/local/app_prefs.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/langauge_manager.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final AppPreferences appPreferences = sl<AppPreferences>();

  LanguageType languageValue = LanguageType.english;

  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  _getLanguage() async {
    String? language = await appPreferences.getAppLanguage();
    setState(() {
      languageValue =
          language == 'ar' ? LanguageType.arabic : LanguageType.english;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            profileAppBar(title: 'language', context: context, isAction: false),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: R.sW(context, 20), vertical: R.sH(context, 10)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'arabic'.tr(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: R.F(context, 18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Radio(
                    value: LanguageType.arabic,
                    groupValue: languageValue,
                    activeColor: AppColors.darkBlue,
                    onChanged: (value) {
                      _changeLanguage();
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'english'.tr(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: R.F(context, 18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Radio(
                    value: LanguageType.english,
                    groupValue: languageValue,
                    activeColor: AppColors.darkBlue,
                    onChanged: (value) {
                      _changeLanguage();
                    }),
              ],
            ),
          ]),
        ));
  }

  _changeLanguage() {
    appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }
}
