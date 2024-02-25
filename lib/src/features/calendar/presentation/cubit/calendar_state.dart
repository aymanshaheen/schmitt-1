import 'package:table_calendar/table_calendar.dart';

class CalendarStates {}

class CalendarInitial extends CalendarStates {}

class CalendarLoading extends CalendarStates {}

class CalendarLoaded extends CalendarStates {}

class CalendarError extends CalendarStates {
  final String message;
  CalendarError(this.message);
}
class CalendarUpdated extends CalendarStates {
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final DateTime selectedDay;

  CalendarUpdated(this.focusedDay, this.calendarFormat, this.selectedDay);
}
