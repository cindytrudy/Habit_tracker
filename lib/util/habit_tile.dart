import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart' 
show CircularPercentIndicator;

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTapped;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.onTap,
    required this.settingsTapped,
    required this.timeSpent,
    required this.habitStarted,
    required this.timeGoal,
  }) : super(key: key);

  // convert seconds into min:sec
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(6);

    // if sec is 1 digit number, add 0 in front 
    if (secs.length == 1) {
      secs = '0 + secs';
    }

    // if mins is a 1 digit number
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    // ignore: prefer_interpolation_to_compose_strings
    return mins + ':' + secs;
  }

  // calculate progress percentage
  double percentCompleted() => timeSpent / timeGoal;

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
                  onTap: onTap,
                  child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: [
                        CircularPercentIndicator(
                          radius: 40,
                          percent:  percentCompleted() ,
                          progressColor: percentCompleted() > 0.5
                          ?(percentCompleted() >0.7
                          ?Colors.green
                          :Colors.orange)
                          :Colors.red,

                        ),
                        // play pause button
                        Center(
                          child: Icon(
                            habitStarted ? Icons.pause : Icons.play_arrow,
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
                      habitName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 3),
                    // progress
                  
                    Text(
                      formatToMinSec(timeSpent) + '/' +
                      timeGoal.toString() + '=' +
                     (percentCompleted() * 100).toStringAsFixed(0) + '%',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTapped,
              child: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}



