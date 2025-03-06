import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, dynamic> conversionTypes = {
    'Meters': 1.0,
    'Kilometers': 0.001,
    'Centimeters': 100,
    'Inches': 39.37,
    'Feet': 3.28084,
  };

  TextEditingController controller = TextEditingController();
  String fromUnit = 'Meters';
  String toUnit = 'Kilometers';
  double result = 0.0;

  void convertUnit() {
    double input = double.tryParse(controller.text) ?? 0.00;
    setState(() {
      result = input * (conversionTypes[toUnit]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Value',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                DropdownButton<String>(
                  value: fromUnit,
                  items:
                      conversionTypes.keys.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                  onChanged: (value) {
                    fromUnit = value!;
                  },
                ),
                Text('To'),
                DropdownButton<String>(
                  value: toUnit,
                  items:
                      conversionTypes.keys.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                  onChanged: (value) {
                    toUnit = value!;
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ElevatedButton(
              onPressed: convertUnit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text('Convert'),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Result: ${result.toString()}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
