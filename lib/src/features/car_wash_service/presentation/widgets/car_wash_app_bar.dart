import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

PreferredSizeWidget carWashAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
      centerTitle: false,
      elevation: 0,
      title: Text(
        title.tr(),
        style: TextStyle(
          fontSize: R.F(context, 18),
          fontWeight: FontWeight.w600,
          fontFamily: "Urbanist",
        ),
      ),
      actions: [
        Container(
            margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
            child: const MoreInfoIcon()),
        SizedBox(
          width: R.sW(context, 15),
        ),
      ]);
}
