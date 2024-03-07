import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_cubit.dart';
import 'package:schmitt/src/features/orders/presentation/screens/cancelled_screen.dart';
import 'package:schmitt/src/features/orders/presentation/screens/completed_screen.dart';
import 'package:schmitt/src/features/orders/presentation/screens/upcoming_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
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
    Tab(text: "upcoming".tr()),
    Tab(text: "completed".tr()),
    Tab(text: "cancelled".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: Text(
            'my_bookings'.tr(),
            style: TextStyle(
              fontSize: R.F(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            const Icon(
              CupertinoIcons.search,
            ),
            SizedBox(
              width: R.sW(context, 10),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.location);
                    },
                    child: const MoreInfoIcon())),
            SizedBox(
              width: R.sW(context, 15),
            )
          ],
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
                insets: EdgeInsets.symmetric(horizontal: R.sH(context, 10))),
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
            CompletedScreen(),
            CancelledScreen(),
          ],
        ),
      ),
    );
  }
}
