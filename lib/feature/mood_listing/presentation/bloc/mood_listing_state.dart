part of '../../mood_listing.feature.dart';

class MoodListingState extends Equatable {
  final List<MoodEntryEntity> moodEntries;

  const MoodListingState({required this.moodEntries});

  factory MoodListingState.initial() => const MoodListingState(moodEntries: []);

  MoodListingState copyWith({List<MoodEntryEntity>? moodEntries}) {
    return MoodListingState(moodEntries: moodEntries ?? this.moodEntries);
  }

  @override
  List<Object?> get props => [moodEntries];
}
