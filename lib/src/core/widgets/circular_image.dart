import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class CircularImageBuilder extends StatelessWidget {
  const CircularImageBuilder({
    super.key,
    required this.photo,
    required this.height,
    required this.width,
  });

  final String photo;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photo,
      placeholder: (context, url) => CircularIndicator(
        color: AppColors.darkBlue,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        width: R.sW(context, width),
        height: R.sH(context, height),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
