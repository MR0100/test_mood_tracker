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

class _MoodEntryCardState extends State<_MoodEntryCard>
    with SingleTickerProviderStateMixin {
  bool _forward = true;
  late final AnimationController _tapController;
  late final Animation<double> _tapCurve;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
      reverseDuration: const Duration(milliseconds: 380),
    );
    _tapCurve = CurvedAnimation(
      parent: _tapController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeOutCubic,
    );
    _tapController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _tapController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

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
        return AnimatedBuilder(
          animation: _tapCurve,
          builder: (context, child) {
            final double reaction = _tapCurve.value.clamp(0.0, 1.0);
            final MoodType mood = widget.entry.type;
            final double shakeDirection = ((reaction * 10).floor().isEven)
                ? 1
                : -1;
            final double shakeX = mood == MoodType.sad
                ? shakeDirection * reaction * 5
                : 0;
            final double rotate = switch (mood) {
              MoodType.happy => reaction * 0.05,
              MoodType.neutral => reaction * 0.01,
              MoodType.sad => -reaction * 0.035,
            };
            final double scale = switch (mood) {
              MoodType.happy => 1 + (reaction * 0.08),
              MoodType.neutral => 1 + (reaction * 0.03),
              MoodType.sad => 1 + (reaction * 0.05),
            };
            final double expressionIntensity = switch (mood) {
              MoodType.happy => reaction,
              MoodType.neutral => reaction * 0.35,
              MoodType.sad => reaction,
            };

            return Transform.translate(
              offset: Offset(shakeX, value * 4),
              child: Transform.rotate(
                angle: rotate,
                child: Transform.scale(
                  scale: scale,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _tapController.forward(from: 0),
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
                                widget.entry.type.color.withValues(
                                  alpha: mood == MoodType.sad
                                      ? (0.25 - (reaction * 0.08)).clamp(
                                          0.15,
                                          0.25,
                                        )
                                      : 0.35,
                                ),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.entry.type.color.withValues(
                                  alpha: 0.20 + (reaction * 0.14),
                                ),
                                blurRadius: 18 + (reaction * 10),
                                offset: const Offset(0, 10),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              width: 2,
                              color: widget.entry.type.color.withValues(
                                alpha: 0.4 + (reaction * 0.2),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.entry.type.name,
                                  style: AppTextStyles.h3.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget
                                      .entry
                                      .timestamp
                                      .formattedTimeDdMdYyyyHhMmAmPm,
                                  style: AppTextStyles.label.copyWith(
                                    color: AppColors.white.withValues(
                                      alpha: 0.9,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Center(
                                  child: Transform.scale(
                                    scale:
                                        1 +
                                        (value.abs() * 0.05) +
                                        (reaction * 0.06),
                                    child: CustomPaint(
                                      size: const Size(94, 94),
                                      painter: MoodFaces(
                                        type: widget.entry.type,
                                        followMouse: true,
                                        pointerXNormalized:
                                            value + (shakeX / 16),
                                        expressionIntensity:
                                            expressionIntensity,
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
                                        alpha: 0.55 + (reaction * 0.2),
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
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
