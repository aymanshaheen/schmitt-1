import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: R.sW(context, 10),),
      padding: EdgeInsets.symmetric(vertical: R.sH(context, 3)),
      height: R.sH(context, 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.searcBarColor,
      ),
      child: TextField(
        onSubmitted: (query) {
          List<Service> searchResults =
              HomeCubit.get(context).getServicesMatching(query);
          Navigator.pushNamed(context, Routes.allServices,
              arguments: searchResults);
        },
        style: TextStyle(
            color: AppColors.black,
            fontSize: R.F(context, 18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.20,
          ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: AppColors.serchBarHintTextColor,
            fontSize: R.F(context, 18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.20,
          ),
          labelStyle:TextStyle(
            color: AppColors.serchBarHintTextColor,
            fontSize: R.F(context, 18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.20,
          ) ,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: 'search'.tr(),
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
