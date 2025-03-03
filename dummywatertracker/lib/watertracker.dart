import 'package:flutter/material.dart';

import 'modifywaterlevel.dart';

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  final int _goal = 2000;
  int _currentInTake = 0;

  void addWater(int amount) {
    setState(() {
      if (_currentInTake < _goal) {
        _currentInTake = (_currentInTake+amount).clamp(0, _goal);
      }
    });
  }

  void resetWater() {
    setState(() {
      _currentInTake = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    double progress = (_currentInTake/_goal);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Water Tracker'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade200,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Today's InTake",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _currentInTake.toString(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade500,
                    color: Colors.blueAccent,
                    strokeWidth: 7,
                    value: progress,
                  ),
                ),
                Text(
                  "${(progress*100).toStringAsFixed(2)}%",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            ModifyWaterLevel(amount: 200, icon: Icons.local_drink,onClick: () => addWater(200)),
            SizedBox(height: 10),
            ModifyWaterLevel(amount: 500,onClick: () => addWater(500)),
            SizedBox(height: 10),
            ModifyWaterLevel(amount: 1000, icon: Icons.local_cafe_rounded,onClick: () => addWater(1000)),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () => resetWater(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 45),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
