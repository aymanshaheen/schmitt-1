
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class NoDataAvailable extends StatelessWidget {
  final String text;
  const NoDataAvailable({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImage.error,
            width: R.sW(context, 200),
            height: R.sH(context, 200),
          ),
          SizedBox(
            height: R.sH(context, 50),
          ),
          Text(
           text.tr(),
            style: TextStyle(
              fontSize: R.F(context, 20),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
