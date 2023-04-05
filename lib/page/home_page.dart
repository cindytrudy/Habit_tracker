import 'package:flutter/material.dart';
import 'dart:async';
import 'package:habit_tracker_app/util/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // overall habit summary
  List habitList = [
    //[ habitName, habitStarter, timeSpent (sec), timeGoal (min)]
    ['Exercise', false, 4, 10],
    ['Nap', false, 0, 20],
    ['Code',false, 0, 30],
    ['Medication',false, 0, 40],   
  ];

  void habitStarted(int index){
    // note what the start time is
    var startTime = DateTime.now();

    //include time already elapsed
    // ignore: unused_local_variable
    int elapsedSeconds = habitList[index][2];

    //habit started or stopped
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      // keep the time going
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          // check when the user stops the timer
          if (habitList[index][1] == false){
            timer.cancel();
          }

          // calculate the time elapsed by comparing current time and start time
          var currentTime = DateTime.now();
          habitList[index][2] = currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - startTime.hour);
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('Settings for ${habitList[index][0]}'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 84, 73),
        title: const Text('Consistency is key'),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            habitName: habitList[index][0], 
            onTap: () {
              habitStarted(index);
            },
            settingsTapped: () {
              settingsOpened(index);
            },
            habitStarted: habitList[index][1],
            timeSpent: habitList[index][2], 
            timeGoal: habitList[index][3]
          );
        }),
      ),
    );
  }
  
  
}

