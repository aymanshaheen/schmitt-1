import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/entities/order.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/customer_info.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/order_items.dart';

class OrderServiceScreen extends StatefulWidget {
  final Order order;
  const OrderServiceScreen({super.key, required this.order});

  @override
  State<OrderServiceScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<OrderServiceScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<Tab> tabs = [
    Tab(text: "order_details".tr()),
    Tab(text: "customer_information".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechCubit,TechState>(
      listener: (context,state) {},
      builder: (context,state) {
        if(state is OrderLoading) {
          return Scaffold(
            body: Center(
              child: CircularIndicator(
                color: AppColors.darkBlue,
              ),
            ),
          );
        }
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(R.sH(context, 50)),
              child: TabBar(
                controller: controller,
                indicator: UnderlineTabIndicator(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    borderSide: BorderSide(
                      width: R.sW(context, 4),
                      color: AppColors.darkBlue,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: R.sH(context, -25))),
                labelColor: AppColors.darkBlue,
                labelStyle: TextStyle(
                  fontSize: R.F(context, 18),
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: AppColors.lightGrey,
                indicatorWeight: R.sW(context, 2),
                tabs: tabs,
              ),
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: <Widget>[
              OrderItems(order: widget.order),
              CustomerInfo(order: widget.order),
            ],
          ),
        );
      }
    );
  }
}
