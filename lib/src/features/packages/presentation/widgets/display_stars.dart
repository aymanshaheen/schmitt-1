import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';

class StarDisplay extends StatelessWidget {
  final double value;
  const StarDisplay({Key? key, this.value = 0})
      : assert(value >= 0 && value <= 5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            Icon(
              Icons.star,
              color: AppColors.grey1,
              size: 30,
            ),
            ClipRect(
              clipper: CustomRect((value - index).clamp(0.0, 1.0)),
              child: Icon(
                Icons.star_rounded,
                color: AppColors.yellow,
                size: 30,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CustomRect extends CustomClipper<Rect> {
  final double value;
  CustomRect(this.value);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(size.width * (1 - value), 0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return value != oldClipper.value;
  }
}
