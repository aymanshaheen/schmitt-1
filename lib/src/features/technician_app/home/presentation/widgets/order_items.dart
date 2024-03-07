import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/functions/date_converter.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/full_rounded_container.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/custom_order_row.dart';

class OrderItems extends StatefulWidget {
  final Order order;
  const OrderItems({super.key, required this.order});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
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
                widget.order.status != "completed"
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.startOrder,
                              arguments: widget.order);
                        },
                        child: FullRounderContainer(
                          circular: 10,
                          containerColor: AppColors.white,
                          textColor: AppColors.darkBlue,
                          title: widget.order.status == "starting"
                              ? "finish_order".tr()
                              : 'start_order'.tr(),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: R.sH(context, 20),
                ),
                Container(
                  padding: EdgeInsets.all(R.sW(context, 20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.grey1!,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRow(
                          title: 'service_type',
                          value: widget.order.services!.first.category!.name!,
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'type_of_service',
                          value: widget.order.services!.first.title,
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'order_status',
                          value: widget.order.status == "starting"
                              ? 'on_going'.tr()
                              : widget.order.status == "completed"
                                  ? 'completed'.tr()
                                  : 'upcoming'.tr(),
                          valueColor: widget.order.status == "starting"
                              ? AppColors.yellow
                              : widget.order.status == "completed"
                                  ? AppColors.green
                                  : AppColors.darkBlue),
                      CustomRow(
                          title: 'ordernumber',
                          value: widget.order.orderNum.toString(),
                          valueColor: AppColors.darkBlue),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'place'.tr(),
                                style: TextStyle(
                                  fontSize: R.F(context, 16),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                ),
                              ),
                              SizedBox(
                                height: R.sH(context, 5),
                              ),
                              SizedBox(
                                width: R.sW(context, 240),
                                child: Text(
                                  widget.order.address?.address ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: R.F(context, 16),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: R.sH(context, 40),
                            width: R.sW(context, 40),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.darkBlue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: AppColors.darkBlue,
                              size: R.sW(context, 25),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: R.sH(context, 20),
                ),
                Text('date'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    )),
                SizedBox(
                  height: R.sH(context, 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 10),
                        vertical: R.sH(context, 10),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.darkBlue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: AppColors.darkBlue,
                            size: R.sW(context, 20),
                          ),
                          SizedBox(
                            width: R.sW(context, 5),
                          ),
                          Text(
                            "clock".tr() +
                                " : " +
                                ConverterDate.convertDate(
                                    widget.order.startAt!, 'en'),
                            style: TextStyle(
                              fontSize: R.F(context, 14),
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: R.sW(context, 10),
                        vertical: R.sH(context, 10),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.darkBlue,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.darkBlue,
                            size: R.sW(context, 20),
                          ),
                          SizedBox(
                            width: R.sW(context, 5),
                          ),
                          Text(
                              '${Localizations.localeOf(context).languageCode != 'en' ? ConverterDate.weekdaysInArabic[DateTime.parse(widget.order.startAt!).weekday] : ConverterDate.weekdaysInEnglish[DateTime.parse(widget.order.startAt!).weekday]} ${DateTime.parse(widget.order.startAt!).day}/${DateTime.parse(widget.order.startAt!).month}/${DateTime.parse(widget.order.startAt!).year}',
                              style: TextStyle(
                                fontSize: R.F(context, 14),
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkBlue,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: R.sH(context, 20),
                ),
                Text('order_details'.tr(),
                    style: TextStyle(
                      fontSize: R.F(context, 16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey,
                    )),
                SizedBox(
                  height: R.sH(context, 10),
                ),
                Container(
                  padding: EdgeInsets.all(R.sW(context, 20)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.grey1!,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomRow(
                          title: 'the_count',
                          value: "1",
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'cost',
                          value: widget.order.price.toString(),
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'transport',
                          value: '22',
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'promo',
                          value: '10',
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'tax',
                          value: '10',
                          valueColor: AppColors.darkBlue),
                      CustomRow(
                          title: 'total',
                          value: '25',
                          valueColor: AppColors.darkBlue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
