import 'package:intl/intl.dart';

class TimeFormat {
  String local(String format, DateTime? dateTime) {
    return DateFormat(format, 'zh_TW').format((dateTime ?? DateTime.now()).toLocal());
  }

  String localFormat(String format, DateTime? dateTime,String local) {
    return DateFormat(format, local).format((dateTime ?? DateTime.now()).toLocal());
  }
}
