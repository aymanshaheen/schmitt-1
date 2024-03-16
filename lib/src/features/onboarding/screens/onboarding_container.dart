import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class OnboardingPage extends StatelessWidget {
  final int pageIndex;
  final String imageUrl;
  final Color containerColor;
  final Color buttonColor;
  final Color richTextColor;
  final Color originalTextColor;
  final String? preRichText;
  final String desc;
  final String desc2;
  final PageController controller;

  const OnboardingPage({
    super.key,
    required this.pageIndex,
    required this.imageUrl,
    required this.containerColor,
    required this.buttonColor,
    required this.richTextColor,
    required this.originalTextColor,
    required this.desc,
    required this.desc2,
    required this.controller,
    this.preRichText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: containerColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: R.sH(context, 500),
            child: Image.asset(
              imageUrl,
              height: R.sH(context, 300),
              width: R.sW(context, 300),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Column(
                children: [
                  SizedBox(height: R.sH(context, 60)),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: R.sH(context, 20),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: preRichText,
                                style: TextStyle(
                                    color: originalTextColor,
                                    fontSize: R.F(context, 25),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: desc,
                                style: TextStyle(
                                    color: richTextColor,
                                    fontSize: R.F(context, 25),
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: desc2,
                                style: TextStyle(
                                    color: originalTextColor,
                                    fontSize: R.F(context, 25),
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                  SizedBox(height: R.sH(context, 40)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (pageIndex != 2) {
                                controller.animateToPage(
                                  pageIndex + 1,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.login);
                              }
                            },
                            child: Container(
                              width: R.sW(context, 300),
                              height: R.sH(context, 50),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: buttonColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                pageIndex == 2 ? 'get_started' : 'next',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: R.F(context, 18),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ).tr(),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 25),
                  ),
                  Visibility(
                    visible: pageIndex != 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.login);
                      },
                      child: Text(
                        "skip".tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: R.F(context, 18),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
