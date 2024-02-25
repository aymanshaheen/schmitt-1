import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/dotted_check_box.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class StepContent extends StatefulWidget {
  final int step;

  const StepContent({super.key, required this.step});

  @override
  State<StepContent> createState() => _StepContentState();
}

class _StepContentState extends State<StepContent> {
  int selectedIndex = 0;
  int? checkedHourIndex;

  void onContainerTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = true;

    switch (widget.step) {
      case 1:
        return Center(
          child: Column(
            children: [
              /*Text(
                'you_dont_have_any_added_address'.tr(),
                style: TextStyle(
                    fontSize: R.F(context, 14),
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey),
              ),*/
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.white,
                  border: Border.all(
                    color: AppColors.darkBlue,
                    width: R.sW(context, 1),
                  ),
                ),
                padding: EdgeInsets.all(R.sW(context, 10)),
                child: Container(
                  padding: EdgeInsets.all(R.sW(context, 10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grey1!,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: CustomPaint(
                          size: Size(R.sW(context, 16), R.sW(context, 16)),
                          painter: DottedCirclePainter(isChecked: isChecked),
                        ),
                      ),
                      SizedBox(width: R.sW(context, 15)),
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/home.svg',
                                width: R.sW(context, 15),
                                height: R.sH(context, 15),
                                color: AppColors.black,
                              ),
                              SizedBox(width: R.sW(context, 2)),
                              Text('Home',
                                  style: TextStyle(
                                    fontSize: R.F(context, 16),
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.black,
                                size: R.sW(context, 20),
                              ),
                              SizedBox(width: R.sW(context, 2)),
                              Column(
                                children: [
                                  Text('Home',
                                      style: TextStyle(
                                        fontSize: R.F(context, 14),
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text('Home',
                                      style: TextStyle(
                                        fontSize: R.F(context, 14),
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(Icons.arrow_back_ios_new, color: AppColors.grey),
                    ],
                  ),
                ),
              ),
              SizedBox(height: R.sH(context, 20)),
              FullRounderContainer(
                  title: "add_new_address".tr(),
                  containerColor: AppColors.white,
                  textColor: AppColors.darkBlue      ,          circular: 30,
)
            ],
          ),
        );
      case 2:
        return Column(
          children: [
            SizedBox(
              height: R.sH(context, 50),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  final formattedDate = DateFormat('MM/dd').format(date);
                  return GestureDetector(
                    onTap: () => onContainerTap(index),
                    child: Container(
                      margin: EdgeInsets.all(R.sW(context, 5)),
                      width: R.sW(context, 70),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.darkBlue, width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color: index == selectedIndex
                            ? AppColors.darkBlue
                            : AppColors.white,
                      ),
                      child: Center(
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            color: index == selectedIndex
                                ? Colors.white
                                : AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            getHourOrder(),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'payment_method'.tr(),
              style: TextStyle(
                fontSize: R.F(context, 16),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: R.sH(context, 20)),
            SizedBox(
              height: R.sH(context, 440),
              child: ListView.builder(
                itemCount: 4,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final hour = index;
                  final isChecked = index == checkedHourIndex;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: R.sH(context, 10),
                        horizontal: R.sW(context, 5)),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            checkedHourIndex = isChecked ? null : index;
                          });
                        },
                        child: Row(
                          children: [
                            CustomPaint(
                              size: Size(R.sW(context, 16), R.sW(context, 16)),
                              painter:
                                  DottedCirclePainter(isChecked: isChecked),
                            ),
                            SizedBox(width: R.sW(context, 15)),
                            Icon(Icons.payment_rounded, color: AppColors.darkBlue),
                            SizedBox(width: R.sW(context, 5)),
                            Text('$hour:00'),
                          ],
                        )),
                  );
                },
              ),
            )
          ],
        );
      default:
        return Text('Default content');
    }
  }

  Widget getHourOrder() {
    switch (selectedIndex) {
      case 0:
        return SizedBox(
          height: R.sH(context, 440),
          child: ListView.builder(
            itemCount: 24,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final hour = index;
              final isChecked = index == checkedHourIndex;
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: R.sH(context, 10), horizontal: R.sW(context, 5)),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        checkedHourIndex = isChecked ? null : index;
                      });
                    },
                    child: Row(
                      children: [
                        CustomPaint(
                          size: Size(R.sW(context, 16), R.sW(context, 16)),
                          painter: DottedCirclePainter(isChecked: isChecked),
                        ),
                        SizedBox(width: R.sW(context, 15)),
                        Text('$hour:00'),
                      ],
                    )),
              );
            },
          ),
        );
      case 1:
        return Text('Content for index 1');
      case 2:
        return Text('Content for index 2');
      // Add more cases as needed...
      default:
        return Text('Default content');
    }
  }
}
