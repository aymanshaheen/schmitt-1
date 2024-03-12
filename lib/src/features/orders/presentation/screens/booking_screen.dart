import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/app_strings.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/circular_indicator.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_cubit.dart';
import 'package:schmitt/src/features/orders/presentation/cubit/booking_state.dart';
import 'package:schmitt/src/features/technician_app/home/presentation/widgets/upcoming_order.dart';

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
    BookingCubit.get(context).recentOrder.clear();
    Future.wait(
      [
        context
            .read<BookingCubit>()
            .getRecentOrders(AppStrings.technicianAssigned),
        context.read<BookingCubit>().getRecentOrders(AppStrings.starting),
      ],
    );

    controller = TabController(
      length: 3,
      vsync: this,
    );
    controller?.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (!(controller?.indexIsChanging ?? true)) {
      switch (controller?.index) {
        case 0:
          BookingCubit.get(context).recentOrder.clear();
          Future.wait(
            [
              context
                  .read<BookingCubit>()
                  .getRecentOrders(AppStrings.technicianAssigned),
              context.read<BookingCubit>().getRecentOrders(AppStrings.starting),
            ],
          );
          break;
        case 1:
          context.read<BookingCubit>().getMyOrders(AppStrings.completed);
          break;
        case 2:
          context.read<BookingCubit>().getMyOrders(AppStrings.cancelled);
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
    Tab(text: "recent".tr()),
    Tab(text: "completed".tr()),
    Tab(text: "cancelled".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
            Icons.search_rounded,
          ),
          SizedBox(
            width: R.sW(context, 15),
          )
        ],
        bottom: TabBar(
          controller: controller,
          indicator: UnderlineTabIndicator(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              borderSide: BorderSide(
                width: R.sW(context, 4),
                color: AppColors.darkBlue,
              ),
              insets: EdgeInsets.symmetric(horizontal: R.sH(context, -20))),
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
      body: BlocConsumer<BookingCubit, BookingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OrderLoading) {
            return SizedBox(
              height: R.sH(context, 500),
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
              UpcomingOrder(
                  orders: BookingCubit.get(context).recentOrder,
                  isEdit: true,
                  isUser: true),
              UpcomingOrder(
                  orders: BookingCubit.get(context).myOrders,
                  isEdit: false,
                  isUser: true),
              UpcomingOrder(
                  orders: BookingCubit.get(context).myOrders,
                  isEdit: false,
                  isUser: true),
            ],
          );
        },
      ),
    );
  }
}
