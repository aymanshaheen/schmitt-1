import 'package:table_calendar/table_calendar.dart';

class BookingDetailsStates {}

class BookingDetailsInitialState extends BookingDetailsStates {}

class NewTimeSelection extends BookingDetailsStates {
  final int index;
  NewTimeSelection(this.index);
}

class CalendarInitial extends BookingDetailsStates {}

class CalendarLoading extends BookingDetailsStates {}

class CalendarLoaded extends BookingDetailsStates {}

class CalendarError extends BookingDetailsStates {
  final String message;
  CalendarError(this.message);
}

class CalendarUpdated extends BookingDetailsStates {
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final DateTime selectedDay;

  CalendarUpdated(this.focusedDay, this.calendarFormat, this.selectedDay);
}
