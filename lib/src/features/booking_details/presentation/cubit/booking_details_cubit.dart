import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/booking_details/presentation/cubit/booking_details_states.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingDetailsCubit extends Cubit<BookingDetailsStates> {
  BookingDetailsCubit() : super(BookingDetailsInitialState());
  static BookingDetailsCubit get(context) => BlocProvider.of(context);

  int timeSelected = 0;

  List<String> selectionTimeList = [
    "9:00 AM".tr(),
    "10:00 AM".tr(),
    "11:00 AM".tr(),
    "12:00 AM".tr(),
    "13:00 PM".tr(),
    "14:00 PM".tr(),
    "15:00 PM".tr(),
    "16:00 PM".tr(),
    "17:00 PM".tr(),
    "18:00 PM".tr(),
    "19:00 PM".tr(),
    "20:00 PM".tr(),
  ];
  selectNewTime(int index) {
    timeSelected = index;
    emit(NewTimeSelection(index));
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;

  late DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;

  void formatChanged(CalendarFormat format) {
    _calendarFormat = format;
    emit(CalendarUpdated(_focusedDay, _calendarFormat, _selectedDay));
  }

  void pageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    emit(CalendarUpdated(_focusedDay, _calendarFormat, _selectedDay));
  }

  void daySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    emit(CalendarUpdated(_focusedDay, _calendarFormat, _selectedDay));
  }
}
