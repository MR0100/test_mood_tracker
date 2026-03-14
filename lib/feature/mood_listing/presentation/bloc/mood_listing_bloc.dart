part of '../../mood_listing.feature.dart';

class MoodListingBloc extends Bloc<MoodListingEvent, MoodListingState> {
  MoodListingBloc() : super(MoodListingState.initial()) {
    on<AddMoodEntryEvent>(_onAddMoodEntryEvent);
    on<DeleteMoodEntryEvent>(_onDeleteMoodEntryEvent);
  }

  // =========[ EVENT HANDLERS ]=========

  /// Add Mood Entry
  Future<void> _onAddMoodEntryEvent(
    AddMoodEntryEvent event,
    Emitter<MoodListingState> emit,
  ) async {
    final List<MoodEntryEntity> newEntries = [
      ...state.moodEntries,
      event.moodEntry,
    ];
    newEntries.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    emit(state.copyWith(moodEntries: newEntries.take(7).toList()));
  }

  /// Delete Mood Entry
  Future<void> _onDeleteMoodEntryEvent(
    DeleteMoodEntryEvent event,
    Emitter<MoodListingState> emit,
  ) async {
    emit(
      state.copyWith(
        moodEntries: state.moodEntries.where((e) => e.id != event.id).toList(),
      ),
    );
  }
}
