import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/more_info_circular_icon.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/orders/presentation/widgets/main_header.dart';
import 'package:schmitt/src/features/calendar/presentation/cubit/calendar_cubit.dart';
import 'package:schmitt/src/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarCubit>(
      create: (context) => CalendarCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'my_calendar'.tr(),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          actions: [
            Container(
                margin: EdgeInsets.symmetric(vertical: R.sH(context, 17)),
                child: const MoreInfoIcon()),
            SizedBox(
              width: R.sW(context, 15),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: R.sW(context, 15), vertical: R.sH(context, 5)),
                margin: EdgeInsets.symmetric(
                  horizontal: R.sW(context, 20),
                  vertical: R.sH(context, 10),
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BlocBuilder<CalendarCubit, CalendarStates>(
                    builder: (context, state) {
                  final cubit = context.read<CalendarCubit>();
                  return TableCalendar(
                    weekNumbersVisible: false,
                    firstDay: DateTime.utc(2023, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: cubit.focusedDay,
                    calendarFormat: cubit.calendarFormat,
                    onFormatChanged: (format) {
                      cubit.formatChanged(format);
                    },
                    onPageChanged: (focusedDay) {
                      cubit.pageChanged(focusedDay);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      cubit.daySelected(selectedDay, focusedDay);
                    },
                  );
                }),
              ),
              SizedBox(
                height: R.sH(context, 10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: R.sW(context, 15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${'service_booking'.tr()} (2)",
                      style: TextStyle(
                        color: AppColors.homeBlackColor,
                        fontSize: R.F(context, 18),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'see_all'.tr(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.homeBlueColor,
                        fontSize: R.F(context, 16),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.20,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: R.sH(context, 10),
              ),
             /* Container(
                color: AppColors.grey1,
                child: Column(
                  children: List.generate(
                    2,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(
                        vertical: R.sH(context, 5),
                        horizontal: R.sW(context, 15),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          R.sW(context, 15),
                        ),
                        child: MainHeader(
                            title: "upcoming".tr(), color: AppColors.lightBlue),
                      ),
                    ),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
