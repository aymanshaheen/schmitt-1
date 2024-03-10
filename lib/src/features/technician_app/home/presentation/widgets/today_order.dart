import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/no_available_data.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/order_content.dart';

class TodayOrder extends StatefulWidget {
  final List<Order> orders;
  const TodayOrder({super.key, required this.orders});

  @override
  State<TodayOrder> createState() => _TodayOrderState();
}

class _TodayOrderState extends State<TodayOrder> {
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
            return const NoDataAvailable(text: "there_is_no_orders_available");
          }
          return RefreshIndicator(
            onRefresh: () async {
              await context
                  .read<TechCubit>()
                  .getOrders(AppStrings.technicianAssigned);
            },
            child: SingleChildScrollView(
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
                      isEdit: false,
                      isUser: false,
                      order: widget.orders[index],
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
