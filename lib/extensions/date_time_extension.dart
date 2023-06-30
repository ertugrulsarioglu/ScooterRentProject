import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String toLongDateTime() {
    final formatter = DateFormat('dd.MM.yyyy HH:mm:ss');
    return formatter.format(this ?? DateTime.now());
  }
}
