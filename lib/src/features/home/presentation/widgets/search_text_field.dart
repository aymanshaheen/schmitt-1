import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: R.sW(context, 10)),
      height: R.sH(context, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.searcBarColor,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: AppColors.serchBarHintTextColor,
            fontSize: R.F(context, 14),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.20,
          ),
          contentPadding: EdgeInsets.only(top: R.sH(context, 13)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'Search',
          suffixIcon: SvgPicture.asset(
            'assets/images/Filter.svg',
            fit: BoxFit.none,
          ),
          prefixIcon: SvgPicture.asset(
            'assets/images/search.svg',
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }
}
