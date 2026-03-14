part of 'extensions.dart';

extension DateTimeExtensions on DateTime {
  /// Convert the date time to DD/MM/YYYY HH:MM AM/PM format.
  String get formattedTimeDdMdYyyyHhMmAmPm => _formatTimeDdMdYyyyHhMmAmPm(this);
}

// Formate time in DD/MM/YYYY HH:MM AM/PM
String _formatTimeDdMdYyyyHhMmAmPm(DateTime timestamp) {
  return DateFormat('dd/MM/yyyy HH:mm a').format(timestamp);
}
