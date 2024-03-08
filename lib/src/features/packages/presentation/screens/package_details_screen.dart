import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/packages/domain/entities/package_entity.dart';
import 'package:schmitt/src/features/packages/presentation/cubit/package_cubit.dart';
import 'package:schmitt/src/features/packages/presentation/widgets/package_reviews.dart';
import 'package:schmitt/src/features/services/domain/entities/review.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service/service_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageDetailsScreen extends StatefulWidget {
  final PackageDataEntity package;
  const PackageDetailsScreen({super.key, required this.package});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen> {
  @override
  void initState() {
    super.initState();
    AppConstants.package = widget.package;
    PackageCubit.get(context).package = null;
    PackageCubit.get(context).getPackage(widget.package.id.toString()).then(
        (value) => PackageCubit.get(context)
                .getReviews(widget.package.id.toString(), AppStrings.allId)
                .then((value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> likedReviews =
                  (prefs.getStringList('likedPackageReviews') ?? []);
              for (Review review in ServiceCubit.get(context).reviews!) {
                review.isLiked = likedReviews.contains(review.id.toString());
                review.likes =
                    prefs.getInt(review.id.toString() + "_likesPackage") ?? 0;
              }
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackageCubit, PackageStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (PackageCubit.get(context).package == null) {
            return Scaffold(
              body: Center(
                  child: CircularIndicator(
                color: AppColors.darkBlue,
              )),
            );
          }
          return Scaffold(
              body: PopScope(
                canPop: false,
                onPopInvoked: (didPop) async {
                  if (didPop) {
                    return;
                  }
                  ServiceCubit.get(context).clearData();
                  Navigator.pop(context);
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: R.sH(context, 40)),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: R.sW(context, 15)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: R.sW(context, 450),
                                height: R.sH(context, 200),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "https://via.placeholder.com/150",
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              SizedBox(height: R.sH(context, 10)),
                              Center(
                                child: Container(
                                  width: R.sW(context, 320),
                                  height: R.sH(context, 55),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.yellow,
                                  ),
                                  child: Center(
                                    child: Text(
                                      widget.package.name!,
                                      style: TextStyle(
                                        color: AppColors.darkBlue,
                                        fontSize: R.F(context, 16),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: R.sH(context, 15)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'price'.tr() + ' : ',
                                    style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: R.F(context, 18),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: R.sW(context, 5)),
                                  Text(
                                    widget.package.price!.toString() + "\$",
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontSize: R.F(context, 16),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: R.sW(context, 5)),
                                  Text(
                                    widget.package.discountPrice!.toString() +
                                        "\$",
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: R.F(context, 16),
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: R.sH(context, 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'duration'.tr(),
                                        style: TextStyle(
                                          color: AppColors.darkBlue,
                                          fontSize: R.F(context, 16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: R.sH(context, 5)),
                                      Text(
                                        widget.package.days!.toString() +
                                            ' ' +
                                            'days'.tr(),
                                        style: TextStyle(
                                          color: AppColors.darkBlue,
                                          fontSize: R.F(context, 16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'number_of_times'.tr(),
                                        style: TextStyle(
                                          color: AppColors.darkBlue,
                                          fontSize: R.F(context, 16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: R.sH(context, 5)),
                                      Text(
                                        widget.package.days!.toString() +
                                            ' ' +
                                            'times'.tr(),
                                        style: TextStyle(
                                          color: AppColors.darkBlue,
                                          fontSize: R.F(context, 16),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: R.sH(context, 15)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'cleints_opinion'.tr()+ ":",
                                    style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: R.F(context, 18),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: R.sH(context, 5)),
                                  ExpandableText(
                                    widget.package.description!,
                                    expandText: 'Read more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: AppColors.darkBlue,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: R.F(context, 16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: R.sH(context, 10)),
                              const PackageReview(),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                  padding: EdgeInsets.only(
                    right: R.sW(context, 10),
                    left: R.sW(context, 10),
                    bottom: R.sH(context, 15),
                    top: R.sH(context, 10),
                  ),
                  height: R.sH(context, 70),
                  color: AppColors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.orderService,
                          arguments: 1);
                    },
                    child: FullRounderContainer(
                        title: "susbcribe_now".tr(),
                        containerColor: AppColors.darkBlue,
                        textColor: AppColors.white,
                        circular: 30),
                  )));
        });
  }
}
