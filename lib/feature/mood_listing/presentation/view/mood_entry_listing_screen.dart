part of '../../mood_listing.feature.dart';

class MoodEntryListingScreen extends StatelessWidget {
  const MoodEntryListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mood Entry Listing",
          style: AppTextStyles.h2.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CorePrimaryButton(
                  title: "Enter Mood",
                  onTap: () {
                    // final String id = DateTime.now().millisecondsSinceEpoch.toString();
                    // final MoodEntryEntity entry = MoodEntryEntity(id: id, type: , timestamp: timestamp, color: color);
                    // context.read<MoodListingBloc>().add(AddMoodEntryEvent(moodEntry: moodEntry))
                  },
                ),
              ],
            ),

            /// MOOD LISTING
            _moodEntriesListing(),
          ],
        ),
      ),
    );
  }

  // List all the Mood entries in horizontal timeline.
  Widget _moodEntriesListing() {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: BlocBuilder<MoodListingBloc, MoodListingState>(
        builder: (context, state) {
          // Empty State
          if (state.moodEntries.isEmpty) {
            return Center(child: Text("No Mood Entries Found"));
          }

          return ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final MoodEntryEntity entry = state.moodEntries[index];
              return Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  color: entry.type.color,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.1),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: state.moodEntries.length,
          );
        },
      ),
    );
  }
}
