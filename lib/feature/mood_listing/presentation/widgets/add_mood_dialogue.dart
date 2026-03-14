part of '../../mood_listing.feature.dart';

class AddMoodDialogue extends StatelessWidget {
  const AddMoodDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.23,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How are you feeling today?",
                style: AppTextStyles.h2.copyWith(color: AppColors.black),
              ),
              SizedBox(height: 8),
              Text(
                "Select the mood face that best describes your day.",
                style: AppTextStyles.body.copyWith(color: AppColors.black),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final MoodType e = MoodType.values[index];
                    return Material(
                      color: Colors.transparent,

                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        splashColor: e.color,
                        hoverColor: e.color,
                        onTap: () {
                          di.get<MoodListingBloc>().add(
                            AddMoodEntryEvent(
                              moodEntry: MoodEntryEntity(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                type: e,
                                timestamp: DateTime.now(),
                                color: e.color,
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: Center(
                            child: CustomPaint(
                              size: Size(100, 100),
                              painter: MoodFaces(type: e),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                  itemCount: MoodType.values.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
