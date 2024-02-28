import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';

class ServiceReview extends StatefulWidget {
  
  const ServiceReview({super.key});

  @override
  _ServiceReviewState createState() => _ServiceReviewState();
}

class _ServiceReviewState extends State<ServiceReview> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
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
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: R.sW(context, 25),
                            child: ClipOval(
                              child: Image.asset(
                                AppImage.profile,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: R.sW(context, 10),
                          ),
                          Text(
                            "Leo Messi",
                            style: TextStyle(
                              color: AppColors.homeBlackColor,
                              fontSize: R.F(context, 16),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          const MoreInfoIcon(),
                          SizedBox(
                            width: R.sW(context, 10),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: R.sW(context, 8)),
                              height: R.sH(context, 28),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppColors.darkBlue,
                                    width: R.sW(context, 2),
                                  ),
                                  color: AppColors.white),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: AppColors.darkBlue,
                                      size: R.sW(context, 16),
                                    ),
                                    SizedBox(
                                      width: R.sW(context, 3),
                                    ),
                                    Text(
                                      "5",
                                      style: TextStyle(
                                        color: AppColors.darkBlue,
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
                        "Awesome service, I really like it and I will use it again and recommend it to my friends.",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFavourite = !isFavourite;
                                  });
                                },
                                child: Icon(
                                  !isFavourite
                                      ? Icons.favorite_border_outlined
                                      : Icons.favorite_rounded,
                                  color: !isFavourite
                                      ? AppColors.black
                                      : AppColors.pink,
                                  size: R.sW(context, 25),
                                ),
                              ),
                              SizedBox(
                                width: R.sW(context, 8),
                              ),
                              Text(
                                "597",
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: R.F(context, 14),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "3 Weeks ago",
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
              );
            },
          );
        });
  }
}
