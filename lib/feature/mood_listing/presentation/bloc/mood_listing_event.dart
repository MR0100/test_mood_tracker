part of '../../mood_listing.feature.dart';

abstract class MoodListingEvent {}

class MoodListingEventInitial extends MoodListingEvent {}

class AddMoodEntryEvent extends MoodListingEvent {
  final MoodEntryEntity moodEntry;

  AddMoodEntryEvent({required this.moodEntry});
}

class DeleteMoodEntryEvent extends MoodListingEvent {
  final String id;

  DeleteMoodEntryEvent({required this.id});
}
