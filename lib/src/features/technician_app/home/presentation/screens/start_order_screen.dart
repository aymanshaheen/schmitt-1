import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/core/widgets/snakbar_builder.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';

class StartOrderScreen extends StatefulWidget {
  final Order order;
  const StartOrderScreen({super.key, required this.order});

  @override
  State<StartOrderScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<StartOrderScreen>
    with TickerProviderStateMixin {
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leadingWidth: R.sW(context, 25),
          elevation: 0,
          title: Text(
            'order_number'.tr() + ' #${widget.order.orderNum.toString()}',
            style: TextStyle(
              fontSize: R.F(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            const MoreInfoIcon(),
            SizedBox(
              width: R.sW(context, 15),
            ),
          ],
        ),
        body: BlocConsumer<TechCubit, TechState>(listener: (context, state) {
          if (state is MarkSuccess) {
            widget.order.status != "starting"
                ? TechCubit.get(context)
                    .getOrders(AppStrings.technicianAssigned)
                : TechCubit.get(context).getMyOrders(AppStrings.starting);
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          if (state is MarkLoading) {
            return Center(
              child: CircularIndicator(
                color: AppColors.darkBlue,
              ),
            );
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: R.sH(context, 10),
                right: R.sW(context, 10),
                left: R.sW(context, 10),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: R.sH(context, 5),
                  horizontal: R.sW(context, 5),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(R.sW(context, 10)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.cameraOrderScreen,
                                arguments: images);
                          },
                          child: FullRounderContainer(
                            circular: 10,
                            containerColor: AppColors.white,
                            textColor: AppColors.darkBlue,
                            title: 'add_photo'.tr(),
                          ),
                        ),
                        SizedBox(
                          height: R.sH(context, 20),
                        ),
                        Container(
                          height: R.sH(context, 550),
                          padding: EdgeInsets.all(R.sW(context, 20)),
                          child: images.isEmpty
                              ? Center(
                                  child: Text(
                                  'no_images_have_added'.tr(),
                                  style: TextStyle(
                                    fontSize: R.F(context, 20),
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          height: R.sH(context, 200),
                                          width: R.sW(context, 200),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.file(
                                              images[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                images.removeAt(index);
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete_outline_rounded,
                                              size: 20,
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: R.sH(context, 20),
              right: R.sW(context, 20),
              left: R.sW(context, 20),
            ),
            child: InkWell(
              onTap: () {
                if (images.isEmpty) {
                  return buildSnakBar(
                      context: context,
                      message: "please_add_image_first".tr(),
                      color: AppColors.error);
                }
                widget.order.status != "starting"
                    ? TechCubit.get(context)
                        .markAsStart(images, widget.order.id.toString())
                    : TechCubit.get(context)
                        .markAsComplete(images, widget.order.id.toString());
              },
              child: FullRounderContainer(
                  title: 'start_order'.tr(),
                  containerColor: AppColors.darkBlue,
                  textColor: AppColors.white,
                  circular: 10),
            )));
  }
}
