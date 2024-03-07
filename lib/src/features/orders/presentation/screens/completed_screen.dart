import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/expandeble_map.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/header_exbanded.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/main_header.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(R.sW(context, 10)),
        child: ListView.builder(
          itemCount: 4,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(
                vertical: R.sH(context, 5),
                horizontal: R.sW(context, 15),
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: R.sH(context, 15),
                  right: R.sW(context, 15),
                  left: R.sW(context, 15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 /*   AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      firstChild: MainHeader(
                        title: "completed".tr(),
                        color: AppColors.green,
                      ),
                      secondChild: HeaderExpanded(
                        title: "completed".tr(),
                        color: AppColors.green,onTap: () {
                           setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                    ),
                    SizedBox(
                      height: R.sH(context, 5),
                    ),
                    Divider(
                      color: AppColors.grey1,
                      thickness: 1,
                    ),
                    Center(
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 400),
                        firstChild: Container(),
                        secondChild: const ExpandebleMap(),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      ),
                    ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.black,
                          size: R.sW(context, 22),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
