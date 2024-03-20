import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/auth/presentation/widgets/custom_login_button.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceReview extends StatefulWidget {
  final int reveiwsCount;
  const ServiceReview({super.key, required this.reveiwsCount});

  @override
  _ServiceReviewState createState() => _ServiceReviewState();
}

class _ServiceReviewState extends State<ServiceReview>
    with TickerProviderStateMixin {
  int _rating = 0;
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
      for (Review review in ServiceCubit.get(context).reviews!) {
        int likes = prefs.getInt(review.id.toString() + "_likes") ?? 0;
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
      List<String> likedReviews = (prefs.getStringList('likedReviews') ?? []);

      setState(() {
        Review review = ServiceCubit.get(context).reviews![index];
        if (review.isLiked) {
          ServiceCubit.get(context).likeReview(index, false);
          review.isLiked = false;
          likedReviews.remove(review.id.toString());
          prefs.setInt(review.id.toString() + "_likes", review.likes);
        } else {
          ServiceCubit.get(context).likeReview(index, true);
          review.isLiked = true;
          likedReviews.add(review.id.toString());
          prefs.setInt(review.id.toString() + "_likes", review.likes);
        }
        prefs.setStringList('likedReviews', likedReviews);
      });
    }

    Future<void> createReview() async {
      if (_reviewController.text.isNotEmpty && _rating != 0) {
        ServiceCubit.get(context).addReview(
            id: AppConstants.service!.id.toString(),
            review: _reviewController.text,
            rating: _rating.toString());
      } else {
        buildSnakBar(
            context: context,
            message: "please_add_review_or_rating".tr(),
            color: AppColors.error);
      }
    }

    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {
      if (state is AddReviweLoaded) {
        ServiceCubit.get(context).service = null;
        Future.wait([
          ServiceCubit.get(context)
              .getServices(1, AppConstants.service!.id.toString()),
          ServiceCubit.get(context)
              .getReviews(AppConstants.service!.id.toString(), AppStrings.allId)
        ]);
      }
    }, builder: (context, state) {
      if (state is GetReviwesLoading) {
        return SizedBox(
          height: R.sH(context, 150) * widget.reveiwsCount.toDouble(),
          child: Center(
              child: CircularIndicator(
            color: AppConstants.service!.category!.id == 4
                ? AppColors.purple
                : AppColors.darkBlue,
          )),
        );
      }
      return Column(
        children: [
          ListView.builder(
              itemCount: ServiceCubit.get(context).reviews!.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Review review = ServiceCubit.get(context).reviews![index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 2500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: -50,
                    child: ScaleAnimation(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Container(
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
                                      placeholder: (context, url) =>
                                          CircularIndicator(
                                        color: AppConstants
                                                    .service!.category!.id ==
                                                4
                                            ? AppColors.purple
                                            : AppColors.darkBlue,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )),
                                  ),
                                  SizedBox(
                                    width: R.sW(context, 10),
                                  ),
                                  Text(
                                    review.author!.name!,
                                    style: TextStyle(
                                      color: AppColors.homeBlackColor,
                                      fontSize: R.F(context, 16),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    width: R.sW(context, 10),
                                  ),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: R.sW(context, 8)),
                                      height: R.sH(context, 28),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: AppConstants.service!
                                                        .category!.id ==
                                                    4
                                                ? AppColors.purple
                                                : AppColors.darkBlue,
                                            width: R.sW(context, 2),
                                          ),
                                          color: AppColors.white),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: AppConstants.service!
                                                          .category!.id ==
                                                      4
                                                  ? AppColors.purple
                                                  : AppColors.darkBlue,
                                              size: R.sW(context, 16),
                                            ),
                                            SizedBox(
                                              width: R.sW(context, 3),
                                            ),
                                            Text(
                                              review.rating!.toString(),
                                              style: TextStyle(
                                                color: AppConstants.service!
                                                            .category!.id ==
                                                        4
                                                    ? AppColors.purple
                                                    : AppColors.darkBlue,
                                                fontSize: R.F(context, 14),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
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
                                linkColor:
                                    AppConstants.service!.category!.id == 4
                                        ? AppColors.purple
                                        : AppColors.darkBlue,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: R.F(context, 16),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: R.sH(context, 8),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              : AppConstants.service!.category!
                                                          .id ==
                                                      4
                                                  ? AppColors.purple
                                                  : AppColors.darkBlue,
                                          size: R.sW(context, 25),
                                        ),
                                      ),
                                      SizedBox(
                                        width: R.sW(context, 8),
                                      ),
                                      Text(
                                        ServiceCubit.get(context)
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          ServiceCubit.get(context).service!.authorize!.review == false
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _rating = index + 1;
                              _controllers[index].forward(from: 0.0);
                            });
                          },
                          child: SizedBox(
                            width: 30.0,
                            height: 30.0,
                            child: AnimatedBuilder(
                              animation: _controllers[index],
                              builder: (_, __) {
                                return Icon(
                                  Icons.star,
                                  color: _rating > index
                                      ? AppConstants.service!.category!.id == 4
                                          ? AppColors.purple
                                          : AppColors.darkBlue
                                      : AppColors.grey1,
                                  size:
                                      30.0 + (10.0 * _controllers[index].value),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: R.sH(context, 20),
                    ),
                    TextField(
                      controller: _reviewController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'write_review'.tr(),
                      ),
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: R.sH(context, 20),
                    ),
                    CustomLoginButton(
                      text: "add_review".tr(),
                      onPressed: createReview,
                      isLoading: state is AddReviweLoading,
                    ),
                    SizedBox(
                      height: R.sH(context, 20),
                    ),
                  ],
                ),
        ],
      );
    });
  }
}
