import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/expandeble_map.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/header_exbanded.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/main_header.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';

class TodayOrder extends StatefulWidget {
  const TodayOrder({super.key});

  @override
  State<TodayOrder> createState() => _TodayOrderState();
}

class _TodayOrderState extends State<TodayOrder> {
  @override
  void initState() {
    super.initState();
  }

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechCubit, TechState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrderLoading) {
            return Center(
                child: CircularIndicator(
              color: AppColors.darkBlue,
            ));
          } else if (TechCubit.get(context).orders.isEmpty) {
            return NoDataAvailable(text: "there_is_no_orders_available".tr());
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: R.sH(context, 10),
                right: R.sW(context, 10),
                left: R.sW(context, 10),
              ),
              child: ListView.builder(
                itemCount: TechCubit.get(context).orders.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.techOrderService,
                          arguments: TechCubit.get(context).orders[index]);
                    },
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
                            AnimatedCrossFade(
                              duration: const Duration(milliseconds: 400),
                              firstChild: HeaderExpanded(
                                order: TechCubit.get(context).orders[index],
                                title: "upcoming".tr(),
                                color: AppColors.darkBlue,
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                              ),
                              secondChild: MainHeader(
                                order: TechCubit.get(context).orders[index],
                                title: "upcoming".tr(),
                                color: AppColors.darkBlue,
                              ),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                            ),
                            SizedBox(
                              height: R.sH(context, 5),
                            ),
                            Center(
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 400),
                                firstChild: Container(),
                                secondChild:  ExpandebleMap(order: TechCubit.get(context).orders[index],),
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                              ),
                            ),
                            isExpanded
                                ? Center(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                      icon: Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.black,
                                        size: R.sW(context, 22),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
