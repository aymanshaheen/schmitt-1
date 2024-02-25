import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:easy_localization/easy_localization.dart';

class FirstMessageSmallCurvedBubble extends StatelessWidget {
  final bool isMe;

  const FirstMessageSmallCurvedBubble({
    super.key,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(isMe, context),
      child: Container(
        width: R.sW(context, 10),
        height: R.sH(context, 15),
        decoration: BoxDecoration(
          color: isMe ? AppColors.darkBlue : AppColors.grey1,
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final bool isMe;
  final BuildContext context;
  MyCustomClipper(this.isMe, this.context);

  @override
  Path getClip(Size size) {
    Path path = Path();
    bool isRtl =
        EasyLocalization.of(context)!.currentLocale!.languageCode == 'ar';
    return isMe ^ isRtl
        ? myCustomRightPath(path, size)
        : senderCustomLeftPath(path, size);
  }

  Path myCustomRightPath(Path path, Size size) {
    double w = size.width;
    double h = size.height;
    path.lineTo(w - 2.5, 0);
    path.quadraticBezierTo(w, 2.5, w - 2.5, 5);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  Path senderCustomLeftPath(Path path, Size size) {
    double w = size.width;
    double h = size.height;
    path.lineTo(2.5, 0);
    path.quadraticBezierTo(0, 2.5, 2.5, 5);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
