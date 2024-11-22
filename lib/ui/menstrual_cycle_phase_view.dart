library menstrual_cycle_widget;

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../menstrual_cycle_widget.dart';
import 'custom_painter/menstrual_cycle_painter.dart';

class MenstrualCyclePhaseView extends StatefulWidget {
  final int totalCycleDays;
  final double selectedDayCircleSize;
  final int selectedDay;

  // Menstruation Params
  final String menstruationName;
  final Color menstruationColor;
  final Color menstruationDayTextColor;
  final Color menstruationTextColor;
  final int menstruationDayCount;
  final Color menstruationBackgroundColor;
  final PhaseTextBoundaries phaseTextBoundaries;

  // Follicular Phase Params
  final String follicularPhaseName;
  final Color follicularPhaseColor;
  final Color follicularPhaseDayTextColor;
  final Color follicularBackgroundColor;
  final Color follicularTextColor;
  final int follicularDayCount;

  // ovulation Phase Params
  final String ovulationName;
  final Color ovulationColor;
  final int ovulationDayCount;
  final Color ovulationDayTextColor;
  final Color ovulationBackgroundColor;
  final Color ovulationTextColor;

  // luteal Phase Params
  final String lutealPhaseName;
  final Color lutealPhaseColor;
  final Color lutealPhaseBackgroundColor;
  final Color lutealPhaseTextColor;
  final Color lutealPhaseDayTextColor;

  // Day Params
  final String dayTitle;
  final double dayTitleFontSize;
  final double dayFontSize;
  final double selectedDayFontSize;
  final Color selectedDayBackgroundColor;
  final Color selectedDayTextColor;
  final Color dayTextColor;
  final Color selectedDayCircleBorderColor;
  final double phasesTextSize;
  final double outsidePhasesTextSize;
  final int outsideTextCharSpace;
  final int outsideTextSpaceFromArc;

  final bool isShowDayTitle;
  final FontWeight dayFontWeight;
  final double circleDaySize;

  final MenstrualCycleTheme theme;

  final double centralCircleSize;
  final Color centralCircleBackgroundColor;
  final Color centralCircleBorderColor;
  final int centralCircleBorderSize;
  final double imgSize;
  final String imageAssets;
  final bool isRemoveBackgroundPhaseColor;

  final MenstrualCycleViewType viewType;

  final String title;
  final Color titleTextColor;
  final double titleTextSize;
  final FontWeight titleFontWeight;

  final String message;
  final String message2;
  final Color messageTextColor;
  final double messageTextSize;
  final FontWeight messageFontWeight;
  final int spaceBtnTitleMessage;

  // Other Variables
  final int menstruationDayCountNew = 0;
  final int follicularDayCountNew = 0;
  final int ovulationDayCountNew = 0;
  final double arcStrokeWidth;
  final double size;

  final bool isAutoSetData;

  const MenstrualCyclePhaseView(
      {super.key,
      this.totalCycleDays = defaultCycleLength,
      required this.size,
      this.selectedDay = 0,

      // Menstruation Params
      this.menstruationName = Strings.menstruationLabel,
      this.menstruationDayCount = defaultPeriodDuration,
      this.menstruationColor = defaultMenstruationColor,
      this.menstruationBackgroundColor = defaultMenstruationColorBg,
      this.menstruationDayTextColor = defaultBlackColor,
      this.menstruationTextColor = defaultMenstruationColor,

      // Follicular Phase Params
      this.follicularPhaseName = Strings.follicularPhaseLabel,
      this.follicularDayCount = defaultFollicularDay,
      this.follicularPhaseDayTextColor = defaultBlackColor,
      this.follicularPhaseColor = defaultFollicularColor,
      this.follicularBackgroundColor = defaultFollicularColorBg,
      this.follicularTextColor = defaultFollicularColor,

      // ovulation Phase Params
      this.ovulationName = Strings.ovulationLabel,
      this.ovulationDayCount = defaultOvulationDay,
      this.ovulationDayTextColor = defaultBlackColor,
      this.ovulationColor = defaultOvulationColor,
      this.ovulationBackgroundColor = defaultOvulationColorBg,
      this.ovulationTextColor = defaultOvulationColor,

      // luteal Phase Params
      this.lutealPhaseName = Strings.lutealPhaseLabel,
      this.lutealPhaseColor = defaultLutealPhaseColor,
      this.lutealPhaseBackgroundColor = defaultLutealPhaseColorBg,
      this.lutealPhaseTextColor = defaultLutealPhaseColor,
      this.lutealPhaseDayTextColor = defaultBlackColor,

      // Central Circle
      this.imageAssets = "",
      this.imgSize = 30,
      this.centralCircleBackgroundColor = defaultCentralCircleBackgroundColor,
      this.centralCircleSize = 25,

      // Day Params
      this.dayTitle = Strings.dayLabel,
      this.dayTitleFontSize = 5,
      this.dayFontSize = 12,
      this.selectedDayCircleSize = 1, //  18 for Arc Theme, 15 for basic theme
      this.dayTextColor = defaultBlackColor,
      this.selectedDayBackgroundColor = Colors.white,
      this.selectedDayFontSize = 12,
      this.selectedDayTextColor = defaultBlackColor,
      this.selectedDayCircleBorderColor = Colors.transparent,
      this.phasesTextSize = 8,
      this.isShowDayTitle = true,
      this.dayFontWeight = FontWeight.normal,
      this.theme = MenstrualCycleTheme.basic,
      this.circleDaySize = 13, //Only when Theme is MenstrualCycleTheme.circle
      this.phaseTextBoundaries = PhaseTextBoundaries.inside,
      this.arcStrokeWidth = 30,
      this.outsidePhasesTextSize = 12,
      this.outsideTextCharSpace = 3,
      this.outsideTextSpaceFromArc = 30,
      this.centralCircleBorderColor = Colors.transparent,
      this.centralCircleBorderSize = 1,
      this.isRemoveBackgroundPhaseColor = false,
      this.viewType = MenstrualCycleViewType.none,
      this.title = "",
      this.titleTextColor = Colors.black,
      this.titleTextSize = 20,
      this.titleFontWeight = FontWeight.bold,
      this.message = "",
      this.message2 = "",
      this.messageTextColor = Colors.black45,
      this.messageTextSize = 10,
      this.messageFontWeight = FontWeight.normal,
      this.spaceBtnTitleMessage = 5,
      this.isAutoSetData = false});

  @override
  State<MenstrualCyclePhaseView> createState() =>
      _MenstrualCyclePhaseViewState();
}

class _MenstrualCyclePhaseViewState extends State<MenstrualCyclePhaseView> {
  final _instance = MenstrualCycleWidget.instance!;

  MenstrualCyclePainter? _painter;
  ui.Image? _image;

  String websiteUrl = Strings.pkgUrl;
  double selectedDayCircleSize = 15;
  double widgetSize = 0;
  PhaseTextBoundaries? phaseTextBoundaries;
  int _totalCycleDays = 0;
  int _menstruationDayCount = 0;
  int _follicularDayCount = defaultFollicularDay;
  int _ovulationDayCount = defaultOvulationDay;
  int _selectedDay = 0;
  String _title = "";
  String _message = "";
  String _message2 = "";

  Future<void> _init(String imagePath) async {
    String lastPeriodDate = _instance.getPreviousPeriodDay();

    if (widget.isAutoSetData) {
      _totalCycleDays = _instance.getCycleLength();
      _menstruationDayCount = _instance.getPeriodDuration();
      _follicularDayCount = getFollicularDayCounts();
      if (lastPeriodDate.isNotEmpty) {
        DateTime lastPeriod = DateTime.parse(lastPeriodDate);
        int inDays = DateTime.now().difference(lastPeriod).inDays;
        printMenstrualCycleLogs("inDays: $inDays");
        if (inDays > _totalCycleDays) {
          _selectedDay = 0;
        } else {
          _selectedDay = (inDays + 1);
        }
      }
      generateMessagesText(lastPeriodDate);
    } else {
      _title = widget.title;
      _message = widget.message;
      _message2 = widget.message2;
      _totalCycleDays = widget.totalCycleDays;
      _menstruationDayCount = widget.menstruationDayCount;
      _follicularDayCount = widget.follicularDayCount;
      _ovulationDayCount = widget.ovulationDayCount;
      _selectedDay = widget.selectedDay;
    }
    if (imagePath.isNotEmpty) {
      final ByteData data = await rootBundle.load(imagePath);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      setState(() {
        _image = frame.image;
      });
    }

    // Set default phase text boundaries to outside if MenstrualCycleViewType.text
    if (widget.viewType == MenstrualCycleViewType.text) {
      if (widget.phaseTextBoundaries == PhaseTextBoundaries.none) {
        phaseTextBoundaries = widget.phaseTextBoundaries;
      } else {
        phaseTextBoundaries = PhaseTextBoundaries.outside;
      }
    } else {
      phaseTextBoundaries = widget.phaseTextBoundaries;
    }

    _painter = MenstrualCyclePainter(
        totalCycleDays: _totalCycleDays,
        menstruationDayCount: _menstruationDayCount,
        follicularDayCount: _follicularDayCount,
        ovulationDayCount: _ovulationDayCount,
        imgSize: widget.imgSize,
        imageAssets: (_image != null) ? _image : null,
        centralCircleBackgroundColor: widget.centralCircleBackgroundColor,
        centralCircleSize: widget.centralCircleSize,
        dayFontSize: widget.dayFontSize,
        selectedDayFontSize: widget.selectedDayFontSize,
        dayTextColor: widget.dayTextColor,
        dayTitle: widget.dayTitle,
        dayTitleFontSize: widget.dayTitleFontSize,
        follicularBackgroundColor: widget.follicularBackgroundColor,
        follicularPhaseColor: widget.follicularPhaseColor,
        follicularPhaseDayTextColor: widget.follicularPhaseDayTextColor,
        follicularPhaseName: widget.follicularPhaseName,
        follicularTextColor: widget.follicularTextColor,
        isShowDayTitle: widget.isShowDayTitle,
        lutealPhaseBackgroundColor: widget.lutealPhaseBackgroundColor,
        lutealPhaseColor: widget.lutealPhaseColor,
        lutealPhaseDayTextColor: widget.lutealPhaseDayTextColor,
        lutealPhaseName: widget.lutealPhaseName,
        lutealPhaseTextColor: widget.lutealPhaseTextColor,
        menstruationBackgroundColor: widget.menstruationBackgroundColor,
        menstruationColor: widget.menstruationColor,
        menstruationDayTextColor: widget.menstruationDayTextColor,
        menstruationName: widget.menstruationName,
        menstruationTextColor: widget.menstruationTextColor,
        ovulationBackgroundColor: widget.ovulationBackgroundColor,
        ovulationColor: widget.ovulationColor,
        ovulationDayTextColor: widget.ovulationDayTextColor,
        ovulationName: widget.ovulationName,
        ovulationTextColor: widget.ovulationTextColor,
        insidePhasesTextSize: widget.phasesTextSize,
        selectedDay: _selectedDay,
        selectedDayBackgroundColor: widget.selectedDayBackgroundColor,
        selectedDayCircleBorderColor: widget.selectedDayCircleBorderColor,
        selectedDayCircleSize: selectedDayCircleSize,
        selectedDayTextColor: widget.selectedDayTextColor,
        dayFontWeight: widget.dayFontWeight,
        theme: widget.theme,
        circleDaySize: widget.circleDaySize,
        phaseTextBoundaries: phaseTextBoundaries!,
        arcStrokeWidth: widget.arcStrokeWidth,
        outsidePhasesTextSize: widget.outsidePhasesTextSize,
        outsideTextCharSpace: widget.outsideTextCharSpace,
        outsideTextSpaceFromArc: widget.outsideTextSpaceFromArc,
        centralCircleBorderColor: widget.centralCircleBorderColor,
        centralCircleBorderSize: widget.centralCircleBorderSize,
        isRemoveBackgroundPhaseColor: widget.isRemoveBackgroundPhaseColor,
        viewType: widget.viewType,
        title: _title,
        titleFontWeight: widget.titleFontWeight,
        titleTextColor: widget.titleTextColor,
        titleTextSize: widget.titleTextSize,
        message: _message,
        message2: _message2,
        messageFontWeight: widget.messageFontWeight,
        messageTextColor: widget.messageTextColor,
        messageTextSize: widget.messageTextSize,
        spaceBtnTitleMessage: widget.spaceBtnTitleMessage);
  }

  /// Generate dynamic messages based on different conditions
  generateMessagesText(lastPeriodDate) {
    if (lastPeriodDate.isNotEmpty) {
      int totalDiffCurrentLastPeriod =
          DateTime.now().difference(DateTime.parse(lastPeriodDate)).inDays;
      printMenstrualCycleLogs(
          "totalDiffCurrentLastPeriod : $totalDiffCurrentLastPeriod");
      int totalDuration =
          _instance.getPeriodDuration() + _instance.getCycleLength();
      printMenstrualCycleLogs("totalDuration : $totalDuration");
      printMenstrualCycleLogs("selected day : $_selectedDay");
      int totalDayBeforeOvulationStart =
          getFollicularDayCounts() + _instance.getPeriodDuration();
      int totalDayBeforeOvulationEnd =
          totalDayBeforeOvulationStart + defaultOvulationDay;
      int conceiveDays =
          totalDayBeforeOvulationStart - totalDiffCurrentLastPeriod;
      printMenstrualCycleLogs(
          "beforeOvulationDayCount : $totalDayBeforeOvulationStart");

      // Check if last period date is more then current cycle length + period duration.
      // Then show only total late period day
      if (totalDiffCurrentLastPeriod >= totalDuration) {
        _message = Strings.pastCycleLabel;
        _title = "$totalDiffCurrentLastPeriod ${Strings.circleDaysLateLabel} ";
        _message2 = Strings.lateLabel;
        return;
      }
      // check if last period date is more then current cycle and less then total duration (current cycle length + period duration)
      // The show below messages
      else if (totalDiffCurrentLastPeriod >= _instance.getCycleLength() &&
          totalDiffCurrentLastPeriod <= totalDuration) {
        _message = Strings.timeForPregnancyTestLabel;
        int dayTestCount = totalDuration - totalDiffCurrentLastPeriod - 1;
        printMenstrualCycleLogs("dayTestCount : $dayTestCount");
        if (dayTestCount == 0) {
          _title = Strings.timeForPregnancyTestTitleLabel3;
        } else {
          if (dayTestCount > 1) {
            _title =
                "${Strings.timeForPregnancyTestTitleLabel} $dayTestCount ${Strings.timeForPregnancyTestTitleLabel4}";
          } else {
            _title =
                "${Strings.timeForPregnancyTestTitleLabel} $dayTestCount ${Strings.timeForPregnancyTestTitleLabel2}";
          }
        }
        _message2 =
            "${Strings.predictPeriodLabel} ${totalDiffCurrentLastPeriod - _instance.getCycleLength() + 1}";
        return;
      }
      // Check if period day started
      // Then show below messages
      else if (totalDiffCurrentLastPeriod >= 0 &&
          totalDiffCurrentLastPeriod < _instance.getPeriodDuration()) {
        _message = Strings.conceiveLabel;
        _title = "$conceiveDays ${Strings.phaseDaysLabel}";
        _message2 = "${Strings.periodPhaseLabel} $_selectedDay ";
        return;
      }
      // Check if period over and before ovulation day
      // Then show below messages
      else if (totalDiffCurrentLastPeriod >= _instance.getPeriodDuration() &&
          totalDiffCurrentLastPeriod < totalDayBeforeOvulationStart) {
        _message = Strings.conceiveLabel;
        if (conceiveDays > 1) {
          _title = "$conceiveDays ${Strings.phaseDaysLabel}";
        } else {
          _title = "$conceiveDays ${Strings.phaseDayLabel}";
        }
        _message2 = Strings.pregnancyChanceMsg1;
        return;
      }
      // Check if ovulation day started
      // Then show below messages
      else if (totalDiffCurrentLastPeriod >= totalDayBeforeOvulationStart &&
          totalDiffCurrentLastPeriod < totalDayBeforeOvulationEnd) {
        int dayOvulationDayCount =
            totalDayBeforeOvulationEnd - totalDiffCurrentLastPeriod - 1;
        int ovulationDay = _instance.getPeriodDuration() +
            getFollicularDayCounts() +
            defaultOvulationDay ~/ 2;
        printMenstrualCycleLogs("ovulationDay $ovulationDay");

        if (ovulationDay == totalDiffCurrentLastPeriod) {
          _message = Strings.ovulationDayMsg1;
          _title = Strings.ovulationDayTitle;
          _message2 = Strings.pregnancyChanceMsg2;
        } else {
          _message = Strings.conceiveLabel2;
          _message2 = Strings.pregnancyChanceMsg2;
          if (dayOvulationDayCount == 0) {
            _title = Strings.timeForPregnancyTestTitleLabel3;
            _message2 = Strings.pregnancyChanceMsg3;
          } else if (dayOvulationDayCount > 1) {
            _title =
                "${Strings.timeForPregnancyTestTitleLabel} $dayOvulationDayCount ${Strings.timeForPregnancyTestTitleLabel4}";
          } else {
            _title =
                "${Strings.timeForPregnancyTestTitleLabel} $dayOvulationDayCount ${Strings.timeForPregnancyTestTitleLabel2}";
          }
        }
      }
      // Check if ovulation day is over and start luteal phase
      else if (totalDiffCurrentLastPeriod >= totalDayBeforeOvulationEnd &&
          totalDiffCurrentLastPeriod <= _instance.getCycleLength()) {
        int totalRemainingDayForNextPeriod =
            _instance.getCycleLength() - totalDiffCurrentLastPeriod;
        if (totalRemainingDayForNextPeriod > 1) {
          _message = Strings.predictPeriodDayStartLabel;
          _title = "$totalRemainingDayForNextPeriod ${Strings.phaseDaysLabel}";
        } else {
          _message = Strings.predictPeriodDayStartLabel2;
          _title = Strings.predictPeriodDayStartLabel1;
        }
        if (totalRemainingDayForNextPeriod < 2) {
          _message2 = Strings.lateLabel;
        } else {
          _message2 = Strings.pregnancyChanceMsg4;
        }
      } else {
        // Never found but still show current date time
        DateTime todayDateTime = DateTime.now();
        _message = CalenderDateUtils.fullDayName(todayDateTime);
        _title = CalenderDateUtils.formatDayMonth(todayDateTime);
        _message2 = CalenderDateUtils.formatYear(todayDateTime);
      }
    } else {
      DateTime todayDateTime = DateTime.now();
      _message = CalenderDateUtils.fullDayName(todayDateTime);
      _title = CalenderDateUtils.formatDayMonth(todayDateTime);
      _message2 = CalenderDateUtils.formatYear(todayDateTime);
    }
  }

  /// Get follicular day count
  int getFollicularDayCounts() {
    int follicularDay = defaultFollicularDay;
    int ovulationDay = _instance.getCycleLength() - 14;
    follicularDay =
        ovulationDay - _instance.getPeriodDuration() - defaultOvulationDay ~/ 2;
    printMenstrualCycleLogs("follicularDay: $follicularDay");
    return follicularDay - 1;
  }

  @override
  void initState() {
    super.initState();
    _checkValidation();
    if (widget.selectedDayCircleSize == 1) {
      if (widget.theme == MenstrualCycleTheme.basic) {
        selectedDayCircleSize = 15;
      } else if (widget.theme == MenstrualCycleTheme.arcs) {
        selectedDayCircleSize = 18;
      }
    } else {
      selectedDayCircleSize = widget.selectedDayCircleSize;
    }
    widgetSize = widget.size;
    if (widget.imageAssets.isNotEmpty) {
      _init(widget.imageAssets);
    } else {
      _init("");
    }
  }

  /// Check Default Validation
  _checkValidation() {
    if (widget.size < 200) {
      throw "${Strings.errorInvalidSize} $websiteUrl";
    }
    if (widget.totalCycleDays < 10) {
      throw "${Strings.errorInvalidCount} $websiteUrl";
    }
    if (widget.menstruationDayCount < 0) {
      throw "${Strings.errorInvalidMenstruationDayCount} $websiteUrl";
    }
    if (widget.follicularDayCount < 0) {
      throw "${Strings.errorInvalidFollicularDayCount} $websiteUrl";
    }
    if (widget.ovulationDayCount < 0) {
      throw "${Strings.errorInvalidOvulationDayCount} $websiteUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    /// set dynamically size if provided size more then current screen size
    if (Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.android) {
      if (MediaQuery.of(context).size.width < widget.size) {
        if (widget.phaseTextBoundaries == PhaseTextBoundaries.both ||
            widget.phaseTextBoundaries == PhaseTextBoundaries.outside) {
          widgetSize = MediaQuery.of(context).size.width - 40;
        } else {
          widgetSize = MediaQuery.of(context).size.width - 10;
        }
      }
    } else if (kIsWeb) {
      if (MediaQuery.of(context).size.height < widget.size) {
        widgetSize = MediaQuery.of(context).size.height - 100;
      }
    }
    return CustomPaint(
      size: Size(widgetSize, widgetSize),
      painter: _painter,
    );
  }
}
