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
