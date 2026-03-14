part of '../../mood_listing.feature.dart';

class MoodEntryListingScreen extends StatefulWidget {
  const MoodEntryListingScreen({super.key});

  @override
  State<MoodEntryListingScreen> createState() => _MoodEntryListingScreenState();
}

class _MoodEntryListingScreenState extends State<MoodEntryListingScreen> {
  double _pointerXNormalized = 0;
  static const double _pointerStep = 0.05;

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

      body: LayoutBuilder(
        builder: (context, constraints) => MouseRegion(
          onHover: (event) {
            final double normalizedX =
                ((event.localPosition.dx / constraints.maxWidth) * 2) - 1;
            final double nextPointer = ((normalizedX.clamp(-1.0, 1.0) / _pointerStep)
                        .round() *
                    _pointerStep)
                .clamp(-1.0, 1.0);
            if (nextPointer != _pointerXNormalized) {
              setState(() => _pointerXNormalized = nextPointer);
            }
          },
          onExit: (_) {
            if (_pointerXNormalized != 0) {
              setState(() => _pointerXNormalized = 0);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: MoodType.values
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CustomPaint(
                                  size: Size(50, 50),
                                  painter: MoodFaces(
                                    type: e,
                                    followMouse: true,
                                    pointerXNormalized: _pointerXNormalized,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    CorePrimaryButton(
                      title: "Enter Mood",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AddMoodDialogue(),
                        );
                      },
                    ),
                  ],
                ),

                /// MOOD LISTING
                const MoodListingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
