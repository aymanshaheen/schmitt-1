import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/app_constants.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/cubit/tech_cubit.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/today_order.dart';

class HomeTechLayoutScreen extends StatefulWidget {
  const HomeTechLayoutScreen({super.key});

  @override
  State<HomeTechLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeTechLayoutScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
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
    Tab(text: "upcoming_orders".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechCubit, TechState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrderLoading) {
            return Scaffold(
                body: Center(
              child: CircularIndicator(
                color: AppColors.darkBlue,
              ),
            ));
          }
          return Scaffold(
            backgroundColor: Colors.grey[100],
            drawer: const Drawer(
              child: ProfileScreen(),
            ),
            appBar: AppBar(
              centerTitle: false,
              leadingWidth: R.sW(context, 5),
              elevation: 0,
              title: Text(
                'home'.tr(),
                style: TextStyle(
                  fontSize: R.F(context, 22),
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.notifications),
                    child: SvgPicture.asset('assets/images/notifications.svg')),
                SizedBox(
                  width: R.sW(context, 20),
                ),
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
                preferredSize: Size.fromHeight(R.sH(context, 110)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: R.sH(context, 10),
                      ),
                      Divider(
                        color: AppColors.grey1,
                      ),
                      SizedBox(
                        height: R.sH(context, 5),
                      ),
                      Row(
                        children: [
                          Text(
                            'good_morning'.tr(),
                            style: TextStyle(
                              color: AppColors.homeGreyColor,
                              fontSize: R.F(context, 16),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.20,
                            ),
                          ),
                          Text(
                            '  ${AppConstants.profile!.name} 👋',
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontSize: R.F(context, 16),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: R.sH(context, 10),
                      ),
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
                            insets: EdgeInsets.symmetric(
                                horizontal: R.sH(context, -25))),
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
            body: TabBarView(
              controller: controller,
              children: <Widget>[
                TodayOrder(orders: TechCubit.get(context).todayOrders),
                TodayOrder(orders: TechCubit.get(context).upcomingOrders),
              ],
            ),
          );
        });
  }
}
