import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_cubit.dart';
import 'package:schmitt/src/features/services/presentation/cubit/service_state.dart';
import 'package:schmitt/src/features/services/presentation/widgets/bottom_navigation_bar.dart';
import 'package:schmitt/src/features/services/presentation/widgets/custom_tab_bar.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:schmitt/src/features/services/presentation/widgets/image_service_container.dart';
import 'package:schmitt/src/features/services/presentation/widgets/offers_listview_item.dart';
import 'package:schmitt/src/features/services/presentation/widgets/service_reviews.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final List<String> imgList = [
    AppImage.houseKeeping,
    AppImage.houseKeeping,
    AppImage.houseKeeping,
    AppImage.houseKeeping,
  ];
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTabController(imgList: imgList),
                SizedBox(height: R.sH(context, 20)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: R.sW(context, 15)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'housekeepings'.tr(),
                              style: TextStyle(
                                fontSize: R.sW(context, 20),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavourite = !isFavourite;
                                });
                              },
                              child: Icon(
                                !isFavourite
                                    ? Icons.bookmark_outline_rounded
                                    : Icons.bookmark_rounded,
                                color: AppColors.darkBlue,
                                size: R.sW(context, 25),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: R.sH(context, 10)),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: R.sW(context, 25),
                            ),
                            SizedBox(width: R.sW(context, 5)),
                            Text(
                              '5',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: R.F(context, 16),
                              ),
                            ),
                            SizedBox(width: R.sW(context, 5)),
                            Text(
                              '(10 ${"reviews".tr()})',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: R.F(context, 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: R.sH(context, 10)),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: R.sW(context, 5)),
                              height: R.sH(context, 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.whiteBlue,
                              ),
                              child: Center(
                                child: Text(
                                  'housekeepings'.tr(),
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: R.F(context, 14),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            SizedBox(width: R.sW(context, 12)),
                            Icon(
                              Icons.location_on,
                              color: AppColors.darkBlue,
                              size: R.sW(context, 25),
                            ),
                            SizedBox(width: R.sW(context, 5)),
                            Flexible(
                              child: Text(
                                '255 Grand Park Avenue',
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: R.F(context, 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: R.sH(context, 15)),
                        Row(
                          children: [
                            Text(
                              "\$50",
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontSize: R.F(context, 26),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: R.sW(context, 10)),
                            Text(
                              "(Room Price)",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: R.F(context, 12),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: R.sH(context, 5)),
                        Divider(
                          thickness: 1,
                          color: AppColors.grey1,
                        ),
                        SizedBox(height: R.sH(context, 10)),
                        Text(
                          'about_me'.tr(),
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: R.F(context, 18),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: R.sH(context, 10)),
                        ExpandableText(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
                        SizedBox(height: R.sH(context, 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'photos%videos'.tr(),
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: R.F(context, 20),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'see_all'.tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.homeBlueColor,
                                fontSize: R.F(context, 16),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: R.sH(context, 10)),
                        const ImageServiceContainer(),
                        SizedBox(height: R.sH(context, 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: R.sW(context, 25),
                                ),
                                SizedBox(width: R.sW(context, 5)),
                                Text(
                                  '5',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: R.F(context, 16),
                                  ),
                                ),
                                SizedBox(width: R.sW(context, 5)),
                                Text(
                                  '(10 ${"reviews".tr()})',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: R.F(context, 14),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'see_all'.tr(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColors.homeBlueColor,
                                fontSize: R.F(context, 16),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: R.sH(context, 10)),
                        SizedBox(
                          height: R.sH(context, 40),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return OffersServiceItem(
                                    title: ServiceCubit.get(context)
                                        .offersList[index],
                                    onTap: () {
                                      ServiceCubit.get(context)
                                          .changeTabbedOffer(index);
                                    });
                              }),
                        ),
                        const ServiceReview(),
                      ]),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomServiceNavigationBar(
            text1: 'message'.tr(),
            text2: 'book_now'.tr(),
            onTap1: () {},
            onTap2: () {
              Navigator.pushNamed(context, Routes.selectRooms);
            },
          ),
        );
      },
    );
  }
}
