part of '../../mood_listing.feature.dart';

enum MoodType {
  happy,
  neutral,
  sad;

  const MoodType();

  Color get color => switch (this) {
    happy => Colors.green,
    neutral => Colors.yellow,
    sad => Colors.red,
  };

  String get name => switch (this) {
    happy => 'Happy',
    neutral => 'Neutral',
    sad => 'Sad',
  };
}
