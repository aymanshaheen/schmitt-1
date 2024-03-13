import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/functions/date_converter.dart';
import 'package:schmitt/src/core/utils/app_image.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_cubit.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_state.dart';

class OrderStatus extends StatefulWidget {
  final Order order;
  const OrderStatus({
    super.key,
    required this.order,
  });

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    widget.order.status == AppStrings.cancelled
        ? currentStep = 0
        : widget.order.status == AppStrings.technicianAssigned
            ? currentStep = 1
            : widget.order.status == AppStrings.starting
                ? currentStep = 2
                : currentStep = 3;
    if (currentStep == 2 || currentStep == 3) {
      BookingCubit.get(context).getAttachments(widget.order.id!.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: R.sH(context, 10),
        right: R.sW(context, 15),
        left: R.sW(context, 15),
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
        child: Column(
          children: [
            SizedBox(
              height: R.sH(context, 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: R.sW(context, 40),
                        height: R.sH(context, 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.darkBlue),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Icon(
                              Icons.check_circle_outline,
                              size: R.sW(context, 25),
                              color: AppColors.white,
                            )),
                      ),
                      SizedBox(
                        width: R.sW(context, 10),
                      ),
                      Text(
                        'orderd_correctly'.tr(),
                        style: TextStyle(
                          fontSize: R.F(context, 14),
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.grey,
                            size: R.sW(context, 14),
                          ),
                          SizedBox(
                            width: R.sW(context, 3),
                          ),
                          Text(
                              '${DateTime.parse(widget.order.startAt!).day}/${DateTime.parse(widget.order.startAt!).month}/${DateTime.parse(widget.order.startAt!).year}',
                              style: TextStyle(
                                fontSize: R.F(context, 10),
                                fontWeight: FontWeight.w600,
                                color: AppColors.grey,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: R.sW(context, 10),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.grey,
                            size: R.sW(context, 14),
                          ),
                          SizedBox(
                            width: R.sW(context, 3),
                          ),
                          Text(
                            'clock'.tr() +
                                ': ' +
                                ConverterDate.formatTime(
                                    DateTime.parse(widget.order.startAt!)),
                            style: TextStyle(
                              fontSize: R.F(context, 10),
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: R.sH(context, 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: R.sW(context, 40),
                        height: R.sH(context, 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentStep == 0
                                ? AppColors.white
                                : AppColors.darkBlue,
                            border: Border.all(
                              color: AppColors.darkBlue,
                            )),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Icon(
                              Icons.person_outline_sharp,
                              size: R.sW(context, 25),
                              color: currentStep == 0
                                  ? AppColors.darkBlue
                                  : AppColors.white,
                            )),
                      ),
                      SizedBox(
                        width: R.sW(context, 10),
                      ),
                      Text(
                        'technican_arrive'.tr(),
                        style: TextStyle(
                          fontSize: R.F(context, 14),
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  currentStep > 1
                      ? Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppColors.grey,
                                  size: R.sW(context, 14),
                                ),
                                SizedBox(
                                  width: R.sW(context, 3),
                                ),
                                Text(
                                    '${DateTime.parse(widget.order.startAt!).day}/${DateTime.parse(widget.order.startAt!).month}/${DateTime.parse(widget.order.startAt!).year}',
                                    style: TextStyle(
                                      fontSize: R.F(context, 10),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.grey,
                                    )),
                              ],
                            ),
                            SizedBox(
                              width: R.sW(context, 10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: AppColors.grey,
                                  size: R.sW(context, 14),
                                ),
                                SizedBox(
                                  width: R.sW(context, 3),
                                ),
                                Text(
                                  'clock'.tr() +
                                      ': ' +
                                      ConverterDate.formatTime(DateTime.parse(
                                          widget.order.startAt!)),
                                  style: TextStyle(
                                    fontSize: R.F(context, 10),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            SizedBox(height: R.sH(context, 10)),
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: R.sW(context, 40),
                        height: R.sH(context, 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentStep == 2
                                ? AppColors.white
                                : currentStep < 2
                                    ? AppColors.white
                                    : AppColors.darkBlue,
                            border: Border.all(
                              color: currentStep == 2
                                  ? AppColors.darkBlue
                                  : currentStep < 2
                                      ? AppColors.grey
                                      : AppColors.darkBlue,
                            )),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Icon(
                              Icons.refresh_rounded,
                              size: R.sW(context, 25),
                              color: currentStep == 2
                                  ? AppColors.darkBlue
                                  : currentStep < 2
                                      ? AppColors.grey
                                      : AppColors.white,
                            )),
                      ),
                      SizedBox(
                        width: R.sW(context, 10),
                      ),
                      Text(
                        'start_working'.tr(),
                        style: TextStyle(
                          fontSize: R.F(context, 14),
                          fontWeight: FontWeight.w600,
                          color: currentStep < 2
                              ? AppColors.grey
                              : AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  currentStep < 2
                      ? const SizedBox.shrink()
                      : BlocBuilder<BookingCubit, BookingStates>(
                          builder: (context, state) {
                          if (state is AttachmentLoading) {
                            return SizedBox(
                              height: R.sH(context, 100),
                              child: Center(
                                child: CircularIndicator(
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: R.sH(context, 100),
                            child: GridView.builder(
                              itemCount:
                                  BookingCubit.get(context).starting.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                   onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Container(
                                          width: R.sW(context, 300),
                                          height: R.sH(context, 300),

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColors.white,
                                              width: R.sW(context, 3)
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                BookingCubit.get(context)
                                                    .starting[index]
                                                    .url!,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: R.sW(context, 50),
                                    height: R.sH(context, 50),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            BookingCubit.get(context)
                                                .starting[index]
                                                .url!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        })
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: R.sW(context, 40),
                        height: R.sH(context, 40),
                        padding: EdgeInsets.all(R.sW(context, 5)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentStep < 3
                                ? AppColors.white
                                : AppColors.darkBlue,
                            border: Border.all(
                              color: currentStep < 3
                                  ? AppColors.grey
                                  : AppColors.darkBlue,
                            )),
                        child: SvgPicture.asset(
                          AppImage.like,
                          color: currentStep < 3
                              ? AppColors.grey
                              : AppColors.white,
                        ),
                      ),
                      SizedBox(
                        width: R.sW(context, 10),
                      ),
                      Text(
                        'finish_working'.tr(),
                        style: TextStyle(
                          fontSize: R.F(context, 14),
                          fontWeight: FontWeight.w600,
                          color: currentStep < 3
                              ? AppColors.grey
                              : AppColors.darkBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  currentStep < 3
                      ? const SizedBox.shrink()
                      : BlocBuilder<BookingCubit, BookingStates>(
                          builder: (context, state) {
                          if (state is AttachmentLoading) {
                            return SizedBox(
                              height: R.sH(context, 100),
                              child: Center(
                                child: CircularIndicator(
                                  color: AppColors.darkBlue,
                                ),
                              ),
                            );
                          }
                          return SizedBox(
                            height: R.sH(context, 200),
                            child: GridView.builder(
                              itemCount:
                                  BookingCubit.get(context).completed.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        child: Container(
                                          width: R.sW(context, 300),
                                          height: R.sH(context, 300),

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: AppColors.white,
                                              width: R.sW(context, 3)
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                BookingCubit.get(context)
                                                    .completed[index]
                                                    .url!,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: R.sW(context, 50),
                                    height: R.sH(context, 50),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          BookingCubit.get(context)
                                              .completed[index]
                                              .url!,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
