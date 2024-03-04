import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';

class StartOrderScreen extends StatefulWidget {
  final Order order;
  const StartOrderScreen({super.key, required this.order});

  @override
  State<StartOrderScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<StartOrderScreen> {
  List<File> images = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        body: BlocConsumer<TechCubit, TechState>(
            listener: (context, state) {},
            builder: (context, state) {
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.grey1!,
                                ),
                              ),
                              child: images.isEmpty
                                  ? const Center(child: Text('No images'))
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: images.length,
                                      itemBuilder: (context, index) {
                                        return Image.file(images[index]);
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
            child: FullRounderContainer(
                title: 'start_order'.tr(),
                containerColor: AppColors.darkBlue,
                textColor: AppColors.white,
                circular: 10)));
  }
}
