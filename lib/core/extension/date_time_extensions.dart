part of 'extensions.dart';

extension DateTimeExtensions on DateTime {
  String get formattedTimeDdMdYyyyHhMmAmPm => _formatTimeDDMMYYYYHHMMAMPM(this);
}

// Formate time in DD/MM/YYYY HH:MM AM/PM
String _formatTimeDDMMYYYYHHMMAMPM(DateTime timestamp) {
  return DateFormat('dd/MM/yyyy HH:mm a').format(timestamp);
}
