part of 'extensions.dart';

extension DateTimeExtensions on DateTime {
  String get formattedTime => _formatTime(this);
}

String _formatTime(DateTime timestamp) {
  final int hour24 = timestamp.hour;
  final int minute = timestamp.minute;
  final bool isPm = hour24 >= 12;
  final int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final String minuteText = minute.toString().padLeft(2, '0');
  final String suffix = isPm ? 'PM' : 'AM';
  return '$hour12:$minuteText $suffix';
}
