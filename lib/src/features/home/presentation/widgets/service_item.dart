import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:schmitt/src/features/services/domain/entities/service.dart';

class ServiceItem extends StatefulWidget {
  final Service services;
  const ServiceItem({super.key, required this.services});

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool? isFavourite;

  @override
  void initState() {
    super.initState();
    isFavourite = widget.services.isFavorited!;
  }

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
                    imageUrl: widget.services.image!.url!,
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              width: R.sW(context, 10),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: R.sH(context, 10),
              ),
              Text(
                widget.services.title,
                style: TextStyle(
                  color: AppColors.homeBlackColor,
                  fontSize: R.F(context, 16),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: R.sH(context, 15),
              ),
              Text(
                "\$${widget.services.price}",
                style: TextStyle(
                  color: AppColors.darkBlue,
                  fontSize: R.F(context, 14),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),
            const Spacer(),
            GestureDetector(
              onTap: () {
                isFavourite!
                    ? HomeCubit.get(context)
                        .deleteBookMark(widget.services.id.toString())
                    : HomeCubit.get(context)
                        .addBookMark(widget.services.id.toString());
                setState(() {
                  isFavourite = !isFavourite!;
                });
              },
              child: Icon(
                !isFavourite!
                    ? Icons.bookmark_outline_rounded
                    : Icons.bookmark_rounded,
                color: AppColors.darkBlue,
                size: R.sW(context, 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
