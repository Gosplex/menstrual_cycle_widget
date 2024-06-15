import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'menstrual_cycle_utils.dart';

class MenstrualCyclePainter extends CustomPainter {
  int totalCycleDays;
  double selectedDayCircleSize;
  int selectedDay;

  // Menstruation Params
  String menstruationName;
  Color menstruationColor;
  Color menstruationDayTextColor;
  Color menstruationTextColor;
  int menstruationDayCount;
  Color menstruationBackgroundColor;
  PhaseTextBoundaries phaseTextBoundaries;

  // Follicular Phase Params
  String follicularPhaseName;
  Color follicularPhaseColor;
  Color follicularPhaseDayTextColor;
  Color follicularBackgroundColor;
  Color follicularTextColor;
  int follicularDayCount;

  // ovulation Phase Params
  String ovulationName;
  Color ovulationColor;
  int ovulationDayCount;
  Color ovulationDayTextColor;
  Color ovulationBackgroundColor;
  Color ovulationTextColor;

  // luteal Phase Params
  String lutealPhaseName;
  Color lutealPhaseColor;
  Color lutealPhaseBackgroundColor;
  Color lutealPhaseTextColor;
  Color lutealPhaseDayTextColor;

  // Day Params
  String dayTitle;
  double dayTitleFontSize;
  double dayFontSize;
  double selectedDayFontSize;
  Color selectedDayBackgroundColor;
  Color selectedDayTextColor;
  Color dayTextColor;
  Color selectedDayCircleBorderColor;
  double insidePhasesTextSize;
  double outsidePhasesTextSize;
  int outsideTextSpaceFromArc;
  int outsideTextCharSpace;
  bool isShowDayTitle;
  FontWeight dayFontWeight;
  double circleDaySize;

  MenstrualCycleTheme theme;
  double centralCircleSize;
  Color centralCircleBackgroundColor;
  double imgSize;
  ui.Image? imageAssets;

  // Other Variables
  int menstruationDayCountNew = 0;
  int follicularDayCountNew = 0;
  int ovulationDayCountNew = 0;
  double arcStrokeWidth = 30;

  static const Color defaultBlackColor = Colors.black;
  static const defaultMenstruationColor = Color(0xFFff584f);
  static const defaultFollicularColor = Color(0xFFeec9b7);
  static const defaultOvulationColor = Color(0xFF22bc79);
  static const defaultLutealPhaseColor = Color(0xFFabcdf0);

  static const defaultMenstruationColorBg = Color(0x26ff584f);
  static const defaultFollicularColorBg = Color(0x26eec9b7);
  static const defaultOvulationColorBg = Color(0x2622bc79);
  static const defaultLutealPhaseColorBg = Color(0x26abcdf0);

  // Default central central background color
  static const defaultCentralCircleBackgroundColor = Color(0xffed9dba);

  MenstrualCyclePainter(
      {required this.totalCycleDays,
      this.selectedDay = 0,
      // Menstruation Params
      this.menstruationName = "Menstruation",
      required this.menstruationDayCount,
      this.menstruationColor = defaultMenstruationColor,
      this.menstruationBackgroundColor = defaultMenstruationColorBg,
      this.menstruationDayTextColor = defaultBlackColor,
      this.menstruationTextColor = defaultMenstruationColor,

      // Follicular Phase Params
      this.follicularPhaseName = "Follicular phase",
      required this.follicularDayCount,
      this.follicularPhaseDayTextColor = defaultBlackColor,
      this.follicularPhaseColor = defaultFollicularColor,
      this.follicularBackgroundColor = defaultFollicularColorBg,
      this.follicularTextColor = defaultFollicularColor,

      // ovulation Phase Params
      this.ovulationName = "Ovulation",
      required this.ovulationDayCount,
      this.ovulationDayTextColor = defaultBlackColor,
      this.ovulationColor = defaultOvulationColor,
      this.ovulationBackgroundColor = defaultOvulationColorBg,
      this.ovulationTextColor = defaultOvulationColor,

      // luteal Phase Params
      this.lutealPhaseName = "Luteal phase",
      this.lutealPhaseColor = defaultLutealPhaseColor,
      this.lutealPhaseBackgroundColor = defaultLutealPhaseColorBg,
      this.lutealPhaseTextColor = defaultLutealPhaseColor,
      this.lutealPhaseDayTextColor = defaultBlackColor,

      // Central Circle
      this.imageAssets,
      this.imgSize = 30,
      this.centralCircleBackgroundColor = defaultCentralCircleBackgroundColor,
      this.centralCircleSize = 25,

      // Day Params
      this.dayTitle = "Day",
      this.dayTitleFontSize = 5,
      this.dayFontSize = 12,
      this.selectedDayFontSize = 18,
      this.selectedDayCircleSize = 18,
      this.dayTextColor = defaultBlackColor,
      this.selectedDayBackgroundColor = Colors.white,
      this.selectedDayTextColor = defaultBlackColor,
      this.selectedDayCircleBorderColor = Colors.transparent,
      this.insidePhasesTextSize = 8,
      this.isShowDayTitle = true,
      this.circleDaySize = 13, //Only when Theme is MenstrualCycleTheme.circle
      this.dayFontWeight = FontWeight.normal,
      this.theme = MenstrualCycleTheme.basic,
      this.phaseTextBoundaries = PhaseTextBoundaries.inside,
      this.arcStrokeWidth = 30,
      this.outsidePhasesTextSize = 12,
      this.outsideTextCharSpace = 3,
      this.outsideTextSpaceFromArc = 30});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final radius = min(size.width / 2, size.height / 2) -
        20; // SK: 20 is Manage circle outerline
    final center = Offset(size.width / 2, size.height / 2);

    menstruationDayCountNew = menstruationDayCount;
    follicularDayCountNew = follicularDayCount + menstruationDayCount;
    ovulationDayCountNew = follicularDayCountNew + ovulationDayCount;

    drawTopAndTextPhase(
        canvas,
        rect,
        center,
        radius,
        0,
        menstruationDayCountNew,
        menstruationColor,
        menstruationBackgroundColor,
        menstruationName,
        menstruationTextColor);
    drawTopAndTextPhase(
        canvas,
        rect,
        center,
        radius,
        menstruationDayCount,
        follicularDayCountNew,
        follicularPhaseColor,
        follicularBackgroundColor,
        follicularPhaseName,
        follicularTextColor);
    drawTopAndTextPhase(
        canvas,
        rect,
        center,
        radius,
        follicularDayCountNew,
        ovulationDayCountNew,
        ovulationColor,
        ovulationBackgroundColor,
        ovulationName,
        ovulationTextColor);
    drawTopAndTextPhase(
        canvas,
        rect,
        center,
        radius,
        ovulationDayCountNew,
        totalCycleDays,
        lutealPhaseColor,
        lutealPhaseBackgroundColor,
        lutealPhaseName,
        lutealPhaseTextColor);

    // SK: Show outside phase text
    if (phaseTextBoundaries == PhaseTextBoundaries.both ||
        phaseTextBoundaries == PhaseTextBoundaries.outside) {
      drawOutSide(canvas, radius, size, menstruationName, 0,
          menstruationDayCountNew, menstruationTextColor);
      drawOutSide(canvas, radius, size, follicularPhaseName,
          menstruationDayCount, follicularDayCountNew, follicularTextColor);
      drawOutSide(canvas, radius, size, ovulationName, follicularDayCountNew,
          ovulationDayCountNew, ovulationTextColor);
      drawOutSide(
        canvas,
        radius,
        size,
        lutealPhaseName,
        ovulationDayCountNew,
        totalCycleDays,
        lutealPhaseTextColor,
      );
    }

    // SK: draw Circle background on center
    final Paint backgroundPaint = Paint()
      ..color = centralCircleBackgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, centralCircleSize, backgroundPaint);

    // SK: Draw the image at the center
    if (imageAssets != null) {
      final paint = Paint()..style = PaintingStyle.stroke;
      final imageSize = Size(imgSize, imgSize);
      final imageOffset = Offset(
        center.dx - imageSize.width / 2,
        center.dy - imageSize.height / 2,
      );
      canvas.drawImageRect(
        imageAssets!,
        Rect.fromLTWH(0, 0, imageAssets!.width.toDouble(),
            imageAssets!.height.toDouble()),
        imageOffset & imageSize,
        paint,
      );
    }

    // SK: For loop for display a Days
    for (int day = 1; day <= totalCycleDays; day++) {
      final startAngle = (2 * pi / totalCycleDays) * (day - 1) - pi / 2;
      final endAngle = (2 * pi / totalCycleDays) * day - pi / 2;
      final middleAngle = (startAngle + endAngle) / 2;

      // Calculate Day position
      final textX = center.dx + radius * cos(middleAngle);
      final textY = center.dy + radius * sin(middleAngle);

      final textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      Color circleBorderColor = getSelectedBorderColor(day);
      Color dayTextColor = getSelectedDayTextColor(day);

      // Draw "Day" label
      TextSpan dayLabel = TextSpan(
        text: dayTitle,
        style: TextStyle(
          color: dayTextColor,
          fontSize: dayTitleFontSize,
          fontWeight: FontWeight.normal,
        ),
      );
      textPainter.text = dayLabel;
      textPainter.layout();
      final labelOffset = Offset(
          textX - textPainter.width / 2,
          textY -
              textPainter.height / 3.5 -
              10); // SK: 10 Mange space btn Day and 'Day' label
      if (isShowDayTitle) {
        textPainter.paint(canvas, labelOffset);
      }

      if (theme == MenstrualCycleTheme.circle) {
        final Paint borderPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(Offset(textX, textY), circleDaySize, borderPaint);

        // SK: set background color of selected day
        final Paint highlightCirclePaint = Paint()
          ..color = circleBorderColor
          ..style = PaintingStyle.fill
          ..strokeWidth = 1;
        canvas.drawCircle(
            Offset(textX, textY), circleDaySize, highlightCirclePaint);

        if (isShowDayTitle) {
          textPainter.paint(canvas, labelOffset);
        }
      }

      // SK: highlight current days
      if (day == selectedDay) {
        // SK: draw outer boarder for selected day
        final Paint borderPaint = Paint()
          ..color = circleBorderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawCircle(
            Offset(textX, textY), selectedDayCircleSize, borderPaint);

        // SK: set background color of selected day
        final Paint highlightCirclePaint = Paint()
          ..color = selectedDayBackgroundColor
          ..style = PaintingStyle.fill
          ..strokeWidth = 2;
        canvas.drawCircle(Offset(textX, textY), selectedDayCircleSize - 1,
            highlightCirclePaint);

        if (isShowDayTitle) {
          textPainter.paint(canvas, labelOffset);
        }
      }

      double topPos = 2;
      if (isShowDayTitle) {
        topPos = 2.5;
      }
      // SK: Display day(number)
      TextSpan dayText = TextSpan(
        text: day.toString(),
        style: TextStyle(
          color: dayTextColor,
          fontSize: (day == selectedDay) ? selectedDayFontSize : dayFontSize,
          fontWeight: dayFontWeight,
        ),
      );
      textPainter.text = dayText;
      textPainter.layout();
      final textOffset = Offset(textX - textPainter.width / 2,
          textY - textPainter.height / topPos); // SK: 2.5 Manage Pos of Day

      textPainter.paint(
        canvas,
        textOffset,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  /// Draw Phase text outside circle like Menstruation, Ovulation etc
  void drawOutSide(Canvas canvas, double radius1, Size size, String text,
      int startDay, int endDay, Color color,
      {Offset? offset, bool adjust = true}) {
    final startAngle = (2 * pi / totalCycleDays) * startDay - pi / 2;
    final sweepAngle = (2 * pi / totalCycleDays) * (endDay - startDay);

    double radius =
        radius1 + outsideTextSpaceFromArc; // Adjust space btn arc and text
    double angle = startAngle;

    if (adjust) {
      angle += sweepAngle / 2 -
          (text.length *
              5 *
              pi /
              600); // Adjust starting angle for centering text
    }

    for (int i = 0; i < text.length; i++) {
      final char = text[i];

      double charAngle = angle +
          i * outsideTextCharSpace * pi / 180; // Adjust character spacing
      Offset charOffset = Offset(
        size.width / 2 + radius * cos(charAngle),
        size.height / 2 + radius * sin(charAngle),
      );

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: char,
          style: TextStyle(
            color: color,
            fontSize: outsidePhasesTextSize,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      canvas.save();
      canvas.translate(charOffset.dx, charOffset.dy);
      canvas.rotate(charAngle + pi / 2);
      textPainter.paint(
          canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  /// Get Selected day text color based on menstrual phase
  Color getSelectedDayTextColor(int day) {
    if (day == selectedDay) {
      if (selectedDayTextColor != Colors.black) {
        return selectedDayTextColor;
      }
      return defaultBlackColor;
    } else {
      if (day <= menstruationDayCount) {
        if (menstruationDayTextColor != defaultBlackColor) {
          return menstruationDayTextColor;
        }
      } else if (day <= follicularDayCountNew) {
        if (follicularPhaseDayTextColor != defaultBlackColor) {
          return follicularPhaseDayTextColor;
        }
      } else if (day <= ovulationDayCountNew) {
        if (ovulationDayTextColor != defaultBlackColor) {
          return ovulationDayTextColor;
        }
      } else {
        if (lutealPhaseDayTextColor != defaultBlackColor) {
          return lutealPhaseDayTextColor;
        }
      }
    }
    return dayTextColor;
  }

  /// Get Selected day border color based on menstrual phase
  Color getSelectedBorderColor(int day) {
    if (selectedDayCircleBorderColor == Colors.transparent) {
      if (day <= menstruationDayCount) {
        return menstruationColor;
      } else if (day <= follicularDayCountNew) {
        return follicularPhaseColor;
      } else if (day <= ovulationDayCountNew) {
        return ovulationColor;
      } else {
        return lutealPhaseColor;
      }
    }
    return selectedDayCircleBorderColor;
  }

  /// Draw top view and inside background
  void drawTopAndTextPhase(
      Canvas canvas,
      Rect rect,
      Offset center,
      double radius,
      int startDay,
      int endDay,
      Color topColor,
      Color bgColor,
      String label,
      Color textColor) {
    final startAngle = (2 * pi / totalCycleDays) * startDay - pi / 2;
    final sweepAngle = (2 * pi / totalCycleDays) * (endDay - startDay);

    // Draw top view
    if (theme == MenstrualCycleTheme.arcs) {
      final paint = Paint()
        ..color = topColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = arcStrokeWidth; // SK: Manage Height of Outer circle
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Draw background
    final paint1 = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint1);

    //SK: set text inside circle
    if (phaseTextBoundaries == PhaseTextBoundaries.both ||
        phaseTextBoundaries == PhaseTextBoundaries.inside) {
      drawPhaseTextInside(
          canvas, center, radius, startDay, endDay, textColor, label);
    }
  }

  /// Draw Phase text inside circle like Menstruation, Ovulation etc
  void drawPhaseTextInside(Canvas canvas, Offset center, double radius,
      int startDay, int endDay, Color textColor, String label) {
    final startAngle = (2 * pi / totalCycleDays) * startDay - pi / 2;
    final sweepAngle = (2 * pi / totalCycleDays) * (endDay - startDay);

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final labelAngle = startAngle + sweepAngle / 2;
    final labelRadius = radius / 2;
    final labelX = center.dx + labelRadius * cos(labelAngle);
    final labelY = center.dy + labelRadius * sin(labelAngle);

    // Calculate rotation angle
    double rotationAngle;
    if (labelAngle > pi / 2 && labelAngle < 3 * pi / 2) {
      rotationAngle = labelAngle - pi;
    } else {
      rotationAngle = labelAngle;
    }

    canvas.save();
    canvas.translate(labelX, labelY);
    canvas.rotate(rotationAngle);
    canvas.translate(-labelX, -labelY);

    final labelText = TextSpan(
      text: label,
      style: TextStyle(
        color: textColor,
        fontSize: insidePhasesTextSize,
        fontWeight: FontWeight.bold,
      ),
    );

    textPainter.text = labelText;
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        labelX - textPainter.width / 2,
        labelY - textPainter.height / 2,
      ),
    );

    canvas.restore();
  }
}
