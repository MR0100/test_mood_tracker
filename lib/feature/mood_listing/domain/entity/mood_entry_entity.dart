part of '../../mood_listing.feature.dart';

class MoodEntryEntity {
  final String id;
  final MoodType type;
  final DateTime timestamp;
  final Color color;

  MoodEntryEntity({
    required this.id,
    required this.type,
    required this.timestamp,
    required this.color,
  });
}
