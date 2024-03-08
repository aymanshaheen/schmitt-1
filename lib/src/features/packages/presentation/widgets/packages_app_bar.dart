import 'package:flutter/material.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

PreferredSizeWidget packageAppBar({
  required BuildContext context,
  required String title,
}) {
  return AppBar(
      centerTitle: false,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: R.F(context, 18),
          fontWeight: FontWeight.w600,
          fontFamily: "Urbanist",
        ),
      ),
      actions: [
        const Icon(Icons.search_rounded),
        SizedBox(
          width: R.sW(context, 10),
        ),
      ]);
}
