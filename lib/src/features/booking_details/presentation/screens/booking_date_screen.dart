import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/config/app_route.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';
import 'package:schmitt/src/core/widgets/responsivity.dart';
import 'package:schmitt/src/features/booking_details/presentation/cubit/booking_details/booking_details_cubit.dart';
import 'package:schmitt/src/features/booking_details/presentation/cubit/booking_details/booking_details_states.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/booking_app_bar.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/booking_button.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/booking_time_selection_item.dart';
import 'package:schmitt/src/features/booking_details/presentation/widgets/cleaning_item.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingDate extends StatelessWidget {
  const BookingDate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookingDetailsCubit>(
      create: (context) => BookingDetailsCubit(),
      child: Scaffold(
        appBar: bookingAppBar(context: context, title: 'Booking Details'.tr()),
        body: Padding(
          padding: EdgeInsets.only(
              left: R.sW(context, 10), right: R.sW(context, 10)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<BookingDetailsCubit, BookingDetailsStates>(
                builder: (context, state) {
              final cubit = context.read<BookingDetailsCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Date',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TableCalendar(
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
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  CleaningItem(
                      widthBetween: R.sW(context, 20),
                      trillingWidget: const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Persons',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'od tempor incididunt ut labore et',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 12,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )),
                  CleaningItem(
                      widthBetween: R.sW(context, 20),
                      trillingWidget: const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Working Hours',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Cost increase after 2 hrs of work.',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 12,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  const Text(
                    'Choose Start Time',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 15),
                  ),
                  SizedBox(
                    height: R.sH(context, 45),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BookingTimeSelectionItem(
                            title: BookingDetailsCubit.get(context)
                                .selectionTimeList[index],
                            onTap: () {
                              BookingDetailsCubit.get(context)
                                  .selectNewTime(index);
                            });
                      },
                      itemCount: BookingDetailsCubit.get(context)
                          .selectionTimeList
                          .length,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  const Text(
                    'Promo Code',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                  Row(
                    children: [
                      Container(
                        height: R.sH(context, 60),
                        width: R.sW(context, R.W(context) - 100),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF9F9F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: R.sW(context, 15)),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter Promo Code',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 86, 42, 42),
                                fontSize: 14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: R.sW(context, 10),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFBFDFF4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Color.fromRGBO(28, 66, 116, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: R.sH(context, 20),
                  ),
                  BookingButton(
                      text: 'Continue',
                      onTap: () {
                        Navigator.pushNamed(context, Routes.location);
                      }),
                  SizedBox(
                    height: R.sH(context, 10),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
