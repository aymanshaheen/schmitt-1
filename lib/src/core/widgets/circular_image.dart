import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
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
    return Container(
      width: R.sW(context, width),
      height: R.sH(context, height),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            photo,
            errorListener: (p0) =>
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
