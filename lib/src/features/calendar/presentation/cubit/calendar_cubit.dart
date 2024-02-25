import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schmitt/src/features/calendar/presentation/cubit/calendar_state.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCubit extends Cubit<CalendarStates> {
  CalendarCubit() : super(CalendarInitial());
  static CalendarCubit get(context) => BlocProvider.of(context);
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
