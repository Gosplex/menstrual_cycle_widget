import 'package:flutter/material.dart';

import '../../menstrual_cycle_widget.dart';
import 'menstrual_cycle_all_history_graph.dart';

class MenstrualCycleHistoryGraph extends StatefulWidget {
  final String headerTitle;
  final TextStyle headerTitleTextStyle;
  final String loadingText;
  final int viewCycleHistoryLength;
  final Color appBarBackgroundColor;
  final EdgeInsetsGeometry? headerPadding;

  const MenstrualCycleHistoryGraph({
    super.key,
    this.headerTitle = Strings.graphCycleTitle,
    this.loadingText = Strings.loading,
    this.appBarBackgroundColor = Colors.blueAccent,
    this.viewCycleHistoryLength = 3,
    this.headerTitleTextStyle = const TextStyle(
        color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
    this.headerPadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  });

  @override
  State<MenstrualCycleHistoryGraph> createState() =>
      _MenstrualCycleHistoryGraphState();
}

class _MenstrualCycleHistoryGraphState
    extends State<MenstrualCycleHistoryGraph> {
  List<PeriodsDateRange> allPeriodRange = [];

  bool isGetData = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final instance = MenstrualCycleWidget.instance!;
    List<PeriodsDateRange> periodRange = await instance.getAllPeriodsDetails();
    for (int i = 0; i < periodRange.length; i++) {
      int cycleDuration = periodRange[i].cycleLength!;
      if (cycleDuration > 0 && cycleDuration < 50) {
        allPeriodRange.add(periodRange[i]);
      }
    }
    // TODO Add Condition to not allow widget.viewCycleHistoryLength is less then zero
    isGetData = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (allPeriodRange.isNotEmpty) {
      return _buildCycleHistoryView();
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (isGetData) ? SizedBox.shrink() : Text(widget.loadingText),
        ),
      );
    }
  }

  /// Returns the cycle history chart.
  _buildCycleHistoryView() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: widget.headerPadding!,
                  child: Text(
                    widget.headerTitle,
                    style: widget.headerTitleTextStyle,
                  ),
                ),
                const SizedBox(),
                (allPeriodRange.length > widget.viewCycleHistoryLength)
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MenstrualAllCycleHistoryGraph(
                                headerTitle: widget.headerTitle,
                                headerTitleTextStyle:
                                    widget.headerTitleTextStyle,
                                loadingText: widget.loadingText,
                                appBarBackgroundColor:
                                    widget.appBarBackgroundColor,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: widget.headerPadding!,
                          child: const Text(
                            Strings.graphCycleViewAllTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const Divider(
              color: Color(0x26212121),
            ),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  itemCount:
                      (allPeriodRange.length > widget.viewCycleHistoryLength)
                          ? widget.viewCycleHistoryLength
                          : allPeriodRange.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (index != 0)
                            ? Text(
                                "${CalenderDateUtils.formatFirstDay(DateTime.parse(allPeriodRange[index].cycleStartDate!))} - ${CalenderDateUtils.formatFirstDay(DateTime.parse(allPeriodRange[index].cycleEndDate!))}",
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "${CalenderDateUtils.formatFirstDay(DateTime.parse(allPeriodRange[index].cycleStartDate!))} - ${Strings.graphCycleNowTitle}",
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 25,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemCount: allPeriodRange[index].cycleLength,
                                itemBuilder: (BuildContext context, int inx) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Container(
                                      width: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: (inx >
                                                allPeriodRange[index]
                                                    .periodDuration!)
                                            ? const Color(0x26212121)
                                            : const Color(0x80ff584f),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Text(
                          "${allPeriodRange[index].periodDuration!} ${Strings.graphCycleDaysPeriod} , ${allPeriodRange[index].cycleLength!} ${Strings.graphCycleDaysCycle}",
                          style: const TextStyle(
                              color: Color(0xA6212121), fontSize: 10),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
