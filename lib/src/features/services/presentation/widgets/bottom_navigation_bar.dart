import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class BottomServiceNavigationBar extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onTap1;
  final Function onTap2;

  const BottomServiceNavigationBar(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.onTap1,
      required this.onTap2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: R.sW(context, 10),
          left: R.sW(context, 10),
          bottom: R.sH(context, 15),
          top: R.sH(context, 10
          ),
      ),
      height: R.sH(context, 70),
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => onTap1(),
            child: Container(
              width: R.sW(context, 140),
              height: R.sH(context, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.whiteBlue,
              ),
              child: Center(
                child: Text(
                  text1,
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontSize: R.F(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onTap2(),
            child: Container(
              width: R.sW(context, 140),
              height: R.sH(context, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.darkBlue,
              ),
              child: Center(
                child: Text(
                  text2,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: R.F(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
