import 'package:intl/intl.dart';

class TimeFormat {
  String local(String format, DateTime? dateTime) {
    return DateFormat(format, 'zh_TW').format((dateTime ?? DateTime.now()).toLocal());
  }
}
