import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
import 'package:schmitt/src/features/packages/presentation/widgets/display_rating.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageReview extends StatefulWidget {
  const PackageReview({super.key});

  @override
  _PackageReviewState createState() => _PackageReviewState();
}

class _PackageReviewState extends State<PackageReview>
    with TickerProviderStateMixin {
  double _rating = 0.0;
  List<AnimationController> _controllers = [];
  final _reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controllers = List.generate(5, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    });

    SharedPreferences.getInstance().then((prefs) {
      for (Review review in PackageCubit.get(context).reviews!) {
        int likes = prefs.getInt(review.id.toString() + "_likesPackage") ?? 0;
        review.likes = likes;
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void toggleLikeReview(int index) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> likedReviews =
          (prefs.getStringList('likedPackageReviews') ?? []);

      setState(() {
        Review review = PackageCubit.get(context).reviews![index];
        if (review.isLiked) {
          PackageCubit.get(context).likeReview(index, false);
          review.isLiked = false;
          likedReviews.remove(review.id.toString());
          prefs.setInt(review.id.toString() + "_likesPackage", review.likes);
        } else {
          PackageCubit.get(context).likeReview(index, true);
          review.isLiked = true;
          likedReviews.add(review.id.toString());
          prefs.setInt(review.id.toString() + "_likesPackage", review.likes);
        }
        prefs.setStringList('likedPackageReviews', likedReviews);
      });
    }

    Future<void> createReview() async {
      if (_reviewController.text.isNotEmpty && _rating != 0) {
        Future.wait([
          PackageCubit.get(context).addReview(
              id: AppConstants.package!.id.toString(),
              review: _reviewController.text,
              rating: _rating.toString()),
        ]);
      } else {
        buildSnakBar(
            context: context,
            message: "please_add_review_or_rating".tr(),
            color: AppColors.error);
      }
    }

    List<String> rateType = [
      "very_bad".tr(),
      "bad".tr(),
      "good".tr(),
      "very_good".tr(),
      "excellent".tr(),
    ];
    return BlocConsumer<PackageCubit, PackageStates>(
        listener: (context, state) {
      if (state is AddReviweLoaded) {
        PackageCubit.get(context)
            .getPackage(AppConstants.package!.id.toString())
            .then((value) => PackageCubit.get(context).getReviews(
                AppConstants.package!.id.toString(), AppStrings.allId));
      }
    }, builder: (context, state) {
      if (state is GetReviwesLoading) {
        return Center(
            child: CircularIndicator(
          color: AppColors.darkBlue,
        ));
      }

      return Column(
        children: [
          ListView.builder(
            itemCount: PackageCubit.get(context).reviews!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Review review = PackageCubit.get(context).reviews![index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: R.sW(context, 15),
                      right: R.sW(context, 15),
                      bottom: R.sH(context, 10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: R.sW(context, 25),
                            child: ClipOval(
                                child: CachedNetworkImage(
                              imageUrl: review.author!.avatar!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => CircularIndicator(
                                color: AppColors.darkBlue,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                          ),
                          SizedBox(
                            width: R.sW(context, 15),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.author!.name!,
                                style: TextStyle(
                                  color: AppColors.homeBlackColor,
                                  fontSize: R.F(context, 16),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              RatingBar.builder(
                                initialRating: review.rating != null
                                    ? review.rating!.toDouble()
                                    : 0.0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 16,
                                
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_rounded,
                                  color: AppColors.yellow,
                                  size: 10,
                                ),
                                onRatingUpdate: (rating) {},
                                ignoreGestures: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: R.sH(context, 8),
                      ),
                      ExpandableText(
                        review.review!,
                        expandText: 'Read more',
                        collapseText: 'show less',
                        maxLines: 4,
                        linkColor: AppColors.darkBlue,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: R.F(context, 16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: R.sH(context, 8),
                      ),
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  toggleLikeReview(index);
                                },
                                child: Icon(
                                  !review.isLiked
                                      ? Icons.favorite_border_outlined
                                      : Icons.favorite_rounded,
                                  color: !review.isLiked
                                      ? AppColors.black
                                      : AppColors.darkBlue,
                                  size: R.sW(context, 25),
                                ),
                              ),
                              SizedBox(
                                width: R.sW(context, 8),
                              ),
                              Text(
                                PackageCubit.get(context)
                                    .reviews![index]
                                    .likes
                                    .toString(),
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: R.F(context, 14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            review.createdAtFormatted!,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: R.F(context, 14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.grey1,
                        thickness: 1,
                      ),*/
                    ],
                  ),
                ),
              );
            },
          ),
          const DisplayRating(),
          BlocBuilder<PackageCubit, PackageStates>(
            builder: (context, state) {
              if (!PackageCubit.get(context).package!.authorize!.review! &&
                  PackageCubit.get(context).reviews!.isNotEmpty) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Center(
                    child: Text(
                      "share_us_your_opinion_about_this_package".tr(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: R.F(context, 18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Center(
                    child: Text(
                      "your_rate_for_this_product".tr() +
                          ": ${_rating == 0 ? "" : rateType[_rating.toInt() - 2]}",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: R.F(context, 16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  RatingBar.builder(
                    initialRating: 0.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 35,
                    itemPadding: EdgeInsets.only(left: R.sW(context, 3)),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rounded,
                      color: AppColors.yellow,
                      size: 10,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating + 1;
                      });
                    },
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  TextField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'write_review'.tr()),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: R.sW(context, 30)),
                    child: InkWell(
                      onTap: createReview,
                      child: Container(
                        width: R.sW(context, 220),
                        height: R.sH(context, 55),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.yellow,
                        ),
                        child: Center(
                          child: BlocBuilder<PackageCubit, PackageStates>(
                            builder: (context, state) {
                              if (state is AddReviweLoading) {
                                return CircularIndicator(
                                  color: AppColors.darkBlue,
                                );
                              }
                              return Text(
                                "add_review".tr(),
                                style: TextStyle(
                                  color: AppColors.darkBlue,
                                  fontSize: R.F(context, 16),
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                ],
              );
            },
          ),
        ],
      );
    });
  }
}
