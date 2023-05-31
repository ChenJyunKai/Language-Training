import 'package:intl/intl.dart';

class TimeFormat {
  String local(String format, DateTime? dateTime) {
    return DateFormat(format, 'zh_CN').format((dateTime ?? DateTime.now()).toLocal());
  }
}
