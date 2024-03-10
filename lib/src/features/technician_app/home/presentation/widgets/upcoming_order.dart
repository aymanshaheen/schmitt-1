import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/order_content.dart';

class UpcomingOrder extends StatefulWidget {
  final List<Order> orders;
  final bool isEdit;
  final bool isUser;
  const UpcomingOrder( {super.key, required this.orders, required this.isEdit, required this.isUser});

  @override
  State<UpcomingOrder> createState() => _UpcomingOrderState();
}

class _UpcomingOrderState extends State<UpcomingOrder> {
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
          } else if (widget.orders.isEmpty) {
            return NoDataAvailable(text: "there_is_no_orders_available".tr());
          }
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                top: R.sH(context, 10),
                right: R.sW(context, 10),
                left: R.sW(context, 10),
              ),
              child: ListView.builder(
                itemCount: widget.orders.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderContent(
                    isEdit: widget.isEdit,
                    isUser: widget.isUser,
                    order: widget.orders[index],
                  );
                },
              ),
            ),
          );
        });
  }
}
