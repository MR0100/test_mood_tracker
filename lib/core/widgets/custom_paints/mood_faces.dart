part of '../widgets.dart';

class MoodFaces extends CustomPainter {
  final MoodType type;

  /// default is false,
  /// followMouse is being used to change the eye movements based on the provided pointerXNormalized value.
  /// when the followMouse is true, eye will move and follow the mouse movements.
  /// when the followMouse is false, eye will not move and will be fixed in the center.
  final bool followMouse;

  /// default is 0,
  /// pointerXNormalized is being used to change the eye movements based on the provided pointerXNormalized value.
  /// when the pointerXNormalized is 0, eye will be fixed in the center.
  /// when the pointerXNormalized is 1, eye will be moved to the right.
  /// when the pointerXNormalized is -1, eye will be moved to the left.
  final double pointerXNormalized;

  /// default is 0,
  /// expressionIntensity is being used to change the expression intensity based on the provided expressionIntensity value.
  final double expressionIntensity;

  MoodFaces({
    super.repaint,
    required this.type,
    this.followMouse = false,
    this.pointerXNormalized = 0,
    this.expressionIntensity = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double faceSize = size.shortestSide;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = faceSize / 2;
    final double clampedIntensity = expressionIntensity.clamp(0.0, 1.0);

    // ============== PAINTS ==============
    final Paint facePaint = Paint()
      ..color = type.color
      ..style = PaintingStyle.fill;

    final double strokeIntensity = (clampedIntensity == 0
        ? 1
        : clampedIntensity * 3);
    final Paint faceBorderPaint = Paint()
      ..color = type.color.withValues(alpha: 0.20 * strokeIntensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = faceSize * 0.1 * strokeIntensity;

    final Paint expressionStrokePaint = Paint()
      ..color = AppColors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = faceSize * 0.03;

    // ============== DRAWINGS ==============

    // face background is always same.
    canvas.drawCircle(center, radius, facePaint);
    canvas.drawCircle(center, radius, faceBorderPaint);

    // eyes are also same for all shapes.
    final double eyeOffsetX = faceSize * 0.18;
    final double eyeY = center.dy - faceSize * 0.14;
    final double baseEyeRadius = faceSize * 0.055;

    // we are changing the eye radius based on the expression intensity.
    final double eyeRadius = switch (type) {
      // increase the eye radius for happy mood.
      MoodType.happy => baseEyeRadius * (1 + (clampedIntensity * 0.20)),
      // no change in the eye radius for neutral mood.
      MoodType.neutral => baseEyeRadius,
      // decrease the eye radius for neutral mood.
      MoodType.sad => baseEyeRadius * (1 - (clampedIntensity * 0.24)),
    };
    final double gazeShift = followMouse
        ? pointerXNormalized.clamp(-1.0, 1.0) * faceSize * 0.1
        : 0;

    // Left Eye
    canvas.drawCircle(
      Offset(center.dx - eyeOffsetX + gazeShift, eyeY),
      eyeRadius,
      expressionStrokePaint,
    );

    // Right Eye
    canvas.drawCircle(
      Offset(center.dx + eyeOffsetX + gazeShift, eyeY),
      eyeRadius,
      expressionStrokePaint,
    );

    // ============== EXPRESSIONs ==============
    final double browY = eyeY - faceSize * 0.12;
    final double browHalfWidth = faceSize * 0.10;
    final double browTilt = faceSize * 0.025 * (1 + (clampedIntensity * 1.3));
    final Path leftBrowPath = Path();
    final Path rightBrowPath = Path();

    final Rect mouthRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + faceSize * 0.18),
      width: faceSize * 0.48,
      height: faceSize * 0.26,
    );

    switch (type) {
      case MoodType.happy:
        leftBrowPath
          ..moveTo(center.dx - eyeOffsetX - browHalfWidth, browY)
          ..lineTo(center.dx - eyeOffsetX + browHalfWidth, browY - browTilt);
        rightBrowPath
          ..moveTo(center.dx + eyeOffsetX - browHalfWidth, browY - browTilt)
          ..lineTo(center.dx + eyeOffsetX + browHalfWidth, browY);
        canvas.drawPath(leftBrowPath, expressionStrokePaint);
        canvas.drawPath(rightBrowPath, expressionStrokePaint);

        // Smile Mouth
        final Rect happyMouthRect = mouthRect.inflate(
          faceSize * 0.06 * clampedIntensity,
        );
        final Path smilePath = Path()..addArc(happyMouthRect, 0.1, 3.0);
        canvas.drawPath(smilePath, expressionStrokePaint);
        break;
      case MoodType.neutral:
        leftBrowPath
          ..moveTo(center.dx - eyeOffsetX - browHalfWidth, browY)
          ..lineTo(center.dx - eyeOffsetX + browHalfWidth, browY);
        rightBrowPath
          ..moveTo(center.dx + eyeOffsetX - browHalfWidth, browY)
          ..lineTo(center.dx + eyeOffsetX + browHalfWidth, browY);
        canvas.drawPath(leftBrowPath, expressionStrokePaint);
        canvas.drawPath(rightBrowPath, expressionStrokePaint);

        // Neutral Mouth
        final Rect neutralMouthRect = Rect.fromCenter(
          center: Offset(center.dx, center.dy + faceSize * 0.24),
          width: faceSize * 0.38,
          height: faceSize * 0.01,
        );
        final Path neutralPath = Path()
          ..moveTo(
            neutralMouthRect.centerLeft.dx,
            neutralMouthRect.centerLeft.dy,
          )
          ..quadraticBezierTo(
            neutralMouthRect.center.dx,
            neutralMouthRect.center.dy + (faceSize * 0.02 * clampedIntensity),
            neutralMouthRect.centerRight.dx,
            neutralMouthRect.centerRight.dy,
          );
        canvas.drawPath(neutralPath, expressionStrokePaint);
        break;
      case MoodType.sad:
        leftBrowPath
          ..moveTo(center.dx - eyeOffsetX - browHalfWidth, browY - browTilt)
          ..lineTo(center.dx - eyeOffsetX + browHalfWidth, browY + browTilt);
        rightBrowPath
          ..moveTo(center.dx + eyeOffsetX - browHalfWidth, browY + browTilt)
          ..lineTo(center.dx + eyeOffsetX + browHalfWidth, browY - browTilt);
        canvas.drawPath(leftBrowPath, expressionStrokePaint);
        canvas.drawPath(rightBrowPath, expressionStrokePaint);

        // Sad Mouth
        final Rect sadMouthRect = mouthRect
            .inflate(faceSize * 0.03 * clampedIntensity)
            .shift(Offset(0, faceSize * (0.18 + (0.04 * clampedIntensity))));
        final Path sadPath = Path()..addArc(sadMouthRect, 3.3, 2.8);
        canvas.drawPath(sadPath, expressionStrokePaint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant MoodFaces oldDelegate) =>
      oldDelegate.type != type ||
      oldDelegate.followMouse != followMouse ||
      oldDelegate.pointerXNormalized != pointerXNormalized ||
      oldDelegate.expressionIntensity != expressionIntensity;
}
