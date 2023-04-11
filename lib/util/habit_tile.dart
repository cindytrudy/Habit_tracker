import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart'
    show CircularPercentIndicator;

class HabitTile extends StatefulWidget {
  final String habitName;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.timeSpent,
    required this.habitStarted,
    required this.timeGoal,
  }) : super(key: key);

  @override
  State<HabitTile> createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  var mTimeSpent = 0;
  var mTimeGoal = 0;
  var mHabitStarted = false;

  String formatTime() {
    return '$mTimeSpent / $mTimeGoal'
        ' = ${(percentCompleted() * 100).toStringAsFixed(0)}';
  }

  double percentCompleted() {
    var percent = mTimeSpent / mTimeGoal;

    if (percent == 1.0) {
      setState(() => mHabitStarted = false);
    }
    return percent < 1 ? percent : 1;
  }

  void startHabit() {
    setState(() => mHabitStarted = true);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => !mHabitStarted ? timer.cancel() : mTimeSpent++);
    });
  }

  @override
  void initState() {
    mTimeSpent = widget.timeSpent;
    mTimeGoal = widget.timeGoal;
    mHabitStarted = widget.habitStarted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, right: 19.0, top: 19.0),
      child: Container(
        padding: const EdgeInsets.all(19.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => startHabit(),
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 40,
                          percent: percentCompleted(),
                          progressColor: percentCompleted() > 0.5
                              ? (percentCompleted() > 0.7
                                  ? Colors.green
                                  : Colors.orange)
                              : Colors.red,
                        ),
                        // play pause button
                        Center(
                          child: Icon(
                            mHabitStarted ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // progress circle
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // habit names
                    Text(
                      widget.habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 3),
                    // progress

                    Text(
                      formatTime(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Settings for ${widget.habitName}'),
                    );
                  },
                );
              },
              child: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
