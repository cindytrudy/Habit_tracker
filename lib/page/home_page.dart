import 'package:flutter/material.dart';
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
    ['Code', false, 0, 30],
    ['Medication', false, 0, 40],
  ];

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
              habitStarted: habitList[index][1],
              timeSpent: habitList[index][2],
              timeGoal: habitList[index][3]);
        }),
      ),
    );
  }
}
