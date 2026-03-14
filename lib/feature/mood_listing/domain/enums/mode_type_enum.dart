part of '../../mood_listing.feature.dart';

enum MoodType {
  happy,
  neutral,
  sad;

  const MoodType();

  Color get color => switch (this) {
    happy => AppColors.happy,
    neutral => AppColors.neutral,
    sad => AppColors.sad,
  };

  String get name => switch (this) {
    happy => 'Happy',
    neutral => 'Neutral',
    sad => 'Sad',
  };
}
