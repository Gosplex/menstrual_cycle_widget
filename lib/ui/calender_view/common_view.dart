import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../menstrual_cycle_widget.dart';
import 'calender_view.dart';

/// get future prediction due periods dates of next period
initFuturePeriodDay() async {
  final instance = MenstrualCycleWidget.instance!;

  List<String> futurePeriodDays = [];
  int generateMonth = 12; // TODO get from Configuration
  int cycleLength = instance.getCycleLength() - 1;
  int periodLength = instance.getPeriodDuration();
  if (instance.lastPeriodDate.isNotEmpty) {
    DateTime nextPeriodDate = DateFormat("yyyy-MM-dd")
        .parse(instance.lastPeriodDate)
        .add(Duration(days: cycleLength));
    // printLogs("Dates: ${defaultDateFormat.format(nextPeriodDate)}");
    for (int index = 0; index < generateMonth; index++) {
      for (int i = 1; i <= periodLength; i++) {
        DateTime addDate = nextPeriodDate.add(Duration(days: i));
        // printLogs("Dates: ${defaultDateFormat.format(addDate)}");
        futurePeriodDays.add(defaultDateFormat.format(addDate));
        // futurePeriodDays
      }
      DateTime newDatetime = nextPeriodDate.add(Duration(days: cycleLength));
      nextPeriodDate = newDatetime;
    }
  }
  return futurePeriodDays;
}

/// get future prediction ovulation dates
initFutureOvulationDay() async {
  final instance = MenstrualCycleWidget.instance!;
  List<String> futureOvulationDays = [];
  int generateMonth = 12; // get from configuration
  int cycleLength = instance.getCycleLength() - 1;
  if (instance.lastPeriodDate.isNotEmpty) {
    DateTime nextPeriodDate = DateFormat("yyyy-MM-dd")
        .parse(instance.lastPeriodDate)
        .add(Duration(days: cycleLength - 1));
    // printLogs("Dates: ${defaultDateFormat.format(nextPeriodDate)}");
    for (int index = 0; index < generateMonth; index++) {
      // Ovulation day
      DateTime ovulationDate = nextPeriodDate
          .add(Duration(days: cycleLength))
          .add(const Duration(days: -15)); // TODO get based on  cycleLength
      futureOvulationDays.add(defaultDateFormat.format(ovulationDate));
      //printLogs("Dates: ${defaultDateFormat.format(ovulationDate)}");
      DateTime newDatetime = nextPeriodDate.add(Duration(days: cycleLength));
      nextPeriodDate = newDatetime;
    }
  }
  return futureOvulationDays;
}

Widget getInformationView(Color daySelectedColor, Color themeColor) {
  const double fontSize = 6;
  const double circleSize = 8;

  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 5,
        ),
        Container(
          margin: const EdgeInsets.only(right: 2.0),
          width: circleSize,
          height: circleSize,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: defaultMenstruationColor,
          ),
        ),
        const Text(
          Strings.periodLabel,
          style: TextStyle(fontSize: fontSize),
        ),
        const SizedBox(
          width: 5,
        ),
        DottedBorder(
          color: defaultOvulationColor,
          borderType: BorderType.circle,
          strokeWidth: 1,
          child: Container(
            margin: const EdgeInsets.only(
              left: 2.0,
              right: 2.0,
            ),
            width: circleSize - 2,
            height: circleSize - 2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          Strings.predictOvulationDateLabel,
          style: TextStyle(fontSize: fontSize),
        ),
        const SizedBox(
          width: 5,
        ),
        DottedBorder(
          color: defaultMenstruationColor,
          borderType: BorderType.circle,
          strokeWidth: 1,
          child: Container(
            margin: const EdgeInsets.only(
              left: 2.0,
              right: 2.0,
            ),
            width: circleSize - 2,
            height: circleSize - 2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          Strings.predictPeriodDateLabel,
          style: TextStyle(fontSize: fontSize),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          margin: const EdgeInsets.only(right: 2.0),
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: daySelectedColor,
          ),
        ),
        const Text(
          Strings.selectedDateLabel,
          style: TextStyle(fontSize: fontSize),
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          margin: const EdgeInsets.only(right: 2.0),
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeColor,
          ),
        ),
        const Text(
          Strings.todayLabel,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    ),
  );
}
