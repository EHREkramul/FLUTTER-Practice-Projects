

import 'package:flutter/material.dart';

class ModifyWaterLevel extends StatelessWidget {
  ModifyWaterLevel({
    super.key,
    required this.amount,
    this.icon,
    required this.onClick,
  });
  final VoidCallback onClick;

  final int amount;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onClick,
          label: Text(
            "+ ${amount}ml",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
          ),
          icon: Icon(icon??Icons.water_drop, color: Colors.white),
        ),
      ),
    );
  }
}