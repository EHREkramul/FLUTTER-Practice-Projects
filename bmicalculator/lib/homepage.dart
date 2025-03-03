import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController feetController = TextEditingController();
  TextEditingController inchController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  late double bmi = 0.00;

  void _calculatedBMI() {
    double height =
        (((double.tryParse(feetController.text) ?? 0.00) * 12) +
            (double.tryParse(inchController.text) ?? 0.00)) *
        0.0254; // In meter

    double weight = double.tryParse(weightController.text) ?? 0.00;

    setState(() {
      bmi = (weight / (height * height));
    });
  }

  String _healthCondition(bmi) {
    String condition = "";
    if (bmi < 18.5) {
      condition = "Underweight";
    } else if (bmi < 25) {
      condition = "Healthy";
    } else if (bmi < 30) {
      condition = "Overweight";
    } else if (bmi < 40) {
      condition = "Obese";
    } else {
      condition = "Severely Obese";
    }
    return condition;
  }

  Color _healthColor(bmi) {
    Color color;
    if (bmi < 18.5) {
      color = Colors.blueAccent;
    } else if (bmi < 25) {
      color = Colors.green;
    } else if (bmi < 30) {
      color = Colors.yellow;
    } else if (bmi < 40) {
      color = Colors.orange;
    } else {
      color = Colors.red;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 6,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: feetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Height (Feet)',
                  labelText: 'Height (Feet)',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: inchController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Height (Inch)',
                  labelText: 'Height (Inch)',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Weight (KG)',
                  labelText: 'Weight',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => _calculatedBMI(),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Center(
              child: SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: 15,
                    maximum: 50,
                    pointers: [NeedlePointer(value: bmi)],
                    annotations: [
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.5,
                        widget: Text(
                          bmi.toStringAsPrecision(4),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    ranges: [
                      GaugeRange(
                        startValue: 15,
                        endValue: 18.5,
                        color: Colors.blueAccent,
                      ),
                      GaugeRange(
                        startValue: 18.5,
                        endValue: 25,
                        color: Colors.green,
                      ),
                      GaugeRange(
                        startValue: 25,
                        endValue: 30,
                        color: Colors.yellow,
                      ),
                      GaugeRange(
                        startValue: 30,
                        endValue: 40,
                        color: Colors.orange,
                      ),
                      GaugeRange(startValue: 40, endValue: 50, color: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              _healthCondition(bmi),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: _healthColor(bmi),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
