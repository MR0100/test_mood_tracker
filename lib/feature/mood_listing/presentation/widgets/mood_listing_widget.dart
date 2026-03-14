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
              return _MoodEntryCard(entry: entry, index: index);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: state.moodEntries.length,
          );
        },
      ),
    );
  }
}

class _MoodEntryCard extends StatefulWidget {
  final MoodEntryEntity entry;
  final int index;

  const _MoodEntryCard({required this.entry, required this.index});

  @override
  State<_MoodEntryCard> createState() => _MoodEntryCardState();
}

class _MoodEntryCardState extends State<_MoodEntryCard> {
  bool _forward = true;

  @override
  Widget build(BuildContext context) {
    final double begin = _forward ? -0.25 : 0.25;
    final double end = _forward ? 0.25 : -0.25;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin, end: end),
      duration: const Duration(milliseconds: 1800),
      curve: Curves.easeInOutSine,
      onEnd: () => setState(() => _forward = !_forward),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * 4),
          child: SizedBox(
            height: 250,
            width: 300,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.entry.type.color.withValues(alpha: 0.95),
                    widget.entry.type.color.withValues(alpha: 0.35),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.entry.type.color.withValues(alpha: 0.20),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 2,
                  color: widget.entry.type.color.withValues(alpha: 0.4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.entry.type.name,
                      style: AppTextStyles.h3.copyWith(color: AppColors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.entry.timestamp.formattedTime,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Transform.scale(
                        scale: 1 + (value.abs() * 0.05),
                        child: CustomPaint(
                          size: const Size(94, 94),
                          painter: MoodFaces(
                            type: widget.entry.type,
                            followMouse: true,
                            pointerXNormalized: value,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 8,
                        width: 80,
                        decoration: BoxDecoration(
                          color: widget.entry.type.color.withValues(
                            alpha: 0.55,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
