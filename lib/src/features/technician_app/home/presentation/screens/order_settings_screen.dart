import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/screens/upcoming_screen.dart';

class OrderSettingScreen extends StatefulWidget {
  const OrderSettingScreen({super.key});

  @override
  State<OrderSettingScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<OrderSettingScreen>
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
    Tab(text: "today_orders".tr()),
    Tab(text: "recent_orders".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: R.sW(context, 25),
        elevation: 0,
        title: Text(
          'my_orders'.tr(),
          style: TextStyle(
            fontSize: R.F(context, 22),
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
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
      body: TabBarView(
        controller: controller,
        children: const <Widget>[
          UpcomingScreen(),
          UpcomingScreen(),
        ],
      ),
    );
  }
}
