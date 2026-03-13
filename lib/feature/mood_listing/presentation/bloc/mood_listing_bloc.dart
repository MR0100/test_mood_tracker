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
    emit(state.copyWith(moodEntries: [...state.moodEntries, event.moodEntry]));
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
