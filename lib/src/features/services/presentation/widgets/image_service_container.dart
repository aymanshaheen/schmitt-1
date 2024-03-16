import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';

class ImageServiceContainer extends StatelessWidget {
  const ImageServiceContainer({super.key});

  Widget buildImage(BuildContext context, String url) {
    return AspectRatio(
      aspectRatio: 2,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Container(
                width: R.sW(context, 300),
                height: R.sH(context, 500),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.white, width: R.sW(context, 3)),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      url,

                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularIndicator(
                color: AppConstants.service!.category!.id == 4
                    ? AppColors.purple
                    : AppColors.darkBlue,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = AppConstants.service!.images!;
    return SizedBox(
      height: R.sH(context, 260),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: buildImage(context, images[1].url!),
                ),
                SizedBox(height: R.sH(context, 10)),
                Expanded(
                  child: buildImage(context, images[2].url!),
                ),
              ],
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 0.6,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Container(

                        width: R.sW(context, 300),
                        height: R.sH(context, 500),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white,
                          border: Border.all(
                              color: AppColors.white, width: R.sW(context, 3)),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(images[0].url!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(R.sW(context, 5)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: images[0].url!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => CircularIndicator(
                        color: AppConstants.service!.category!.id == 4
                            ? AppColors.purple
                            : AppColors.darkBlue,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
