import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/upcoming_order.dart';

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
    if (TechCubit.get(context).myOrders.isEmpty) {
      context.read<TechCubit>().getMyOrders(AppStrings.starting);
    }
    controller = TabController(
      length: 2,
      vsync: this,
    );
    controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (!(controller?.indexIsChanging ?? true)) {
      switch (controller?.index) {
        case 0:
          context.read<TechCubit>().getMyOrders(AppStrings.starting);
          break;
        case 1:
          context.read<TechCubit>().getMyOrders(AppStrings.completed);
          break;
      }
    }
  }

  @override
  void dispose() {
    controller?.removeListener(_handleTabSelection);
    controller?.dispose();
    super.dispose();
  }

  List<Tab> tabs = [
    Tab(text: "recent_orders".tr()),
    Tab(text: "completed_orders".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: const Drawer(
        child: ProfileScreen(),
      ),
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: R.sW(context, 10),
        elevation: 0,
        title: Text(
          'my_orders'.tr(),
          style: TextStyle(
            fontSize: R.F(context, 22),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const MoreInfoIcon(),
            ),
          ),
          SizedBox(
            width: R.sW(context, 15),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(R.sH(context, 70)),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: R.sW(context, 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  controller: controller,
                  indicator: UnderlineTabIndicator(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      borderSide: BorderSide(
                        width: R.sW(context, 4),
                        color: AppColors.darkBlue,
                      ),
                      insets:
                          EdgeInsets.symmetric(horizontal: R.sH(context, -25))),
                  labelColor: AppColors.darkBlue,
                  labelStyle: TextStyle(
                    fontSize: R.F(context, 18),
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelColor: AppColors.lightGrey,
                  indicatorWeight: R.sW(context, 2),
                  tabs: tabs,
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocConsumer<TechCubit, TechState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrderLoading) {
            return SizedBox(
             height:  R.sH(context, 500),
              child: Center(
                child: CircularIndicator(
                  color: AppColors.darkBlue,
                ),
              ),
            );
          }
          return TabBarView(
            controller: controller,
            children: <Widget>[
              UpcomingOrder(orders: TechCubit.get(context).myOrders),
              UpcomingOrder(orders: TechCubit.get(context).myOrders),
            ],
          );
        },
      ),
    );
  }
}