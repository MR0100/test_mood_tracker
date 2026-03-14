part of '../../mood_listing.feature.dart';

class MoodListingWidget extends StatelessWidget {
  const MoodListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: BlocBuilder<MoodListingBloc, MoodListingState>(
        buildWhen: (previous, current) =>
            previous.moodEntries != current.moodEntries,
        builder: (context, state) {
          // Empty State
          if (state.moodEntries.isEmpty) {
            return Center(child: Text("No Mood Entries Found"));
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final MoodEntryEntity entry = state.moodEntries[index];
              return MoodEntryCard(entry: entry, index: index);
            },
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: state.moodEntries.length,
          );
        },
      ),
    );
  }
}
