import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_state.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class FavouriteItem extends StatelessWidget {
  final Service bookMark;
  final bool isFavourite = false;
  final VoidCallback onDelete;

  const FavouriteItem({
    Key? key,
    required this.bookMark,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: R.sH(context, 5),
        horizontal: R.sW(context, 15),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(R.sW(context, 15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: R.sW(context, 90),
              height: R.sH(context, 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: bookMark.image!.url!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularIndicator(
                      color: AppColors.darkBlue,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
            ),
            SizedBox(
              width: R.sW(context, 10),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: R.sH(context, 5),
              ),
              Text(
                bookMark.title,
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 16),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: R.sH(context, 5),
              ),
              Text(
                bookMark.price,
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: R.F(context, 14),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: R.sH(context, 5),
              ),
              Text(
                bookMark.description,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: R.F(context, 12),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]),
            const Spacer(),
            BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      onDelete();
                    },
                    child: Icon(
                      isFavourite
                          ? Icons.bookmark_outline_rounded
                          : Icons.bookmark_rounded,
                      color: AppColors.darkBlue,
                      size: R.sW(context, 25),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
