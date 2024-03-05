import 'package:schmitt/src/core/functions/date_converter.dart';

extension DateUtil on DateTime {
  String get lastSeen {
    return 'last seen ${ConverterDate.getLastSeenDayTime(this)} at ${ConverterDate.dateConverterHoursAmPmMode(this)}';
  }
  String get amPmMode{
    return ConverterDate.dateConverterHoursAmPmMode(this);
  }
  String get chatDayTime{
    return ConverterDate.getChatDayTime(this);
  }
  String get chatContactTime{
    return ConverterDate.getChatContactTime(this);
  }
  bool isSameDay(DateTime day2){
    return ConverterDate.isSameDay(this, day2);
  }
}