import 'package:flutter/material.dart';

import 'buildbutton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _input = "";
  String _output = "0";
  String operator = '';
  double num1 = 0;
  double num2 = 0;

  void buttonPressed(String value) {
    setState(() {
      if(num2 != 0 || _output == 'Undefined'){
        _input = '';
        _output = '0';
        operator = '';
        num1 = 0;
        num2 = 0;
      }
      if (value == 'C') {
        _input = '';
        _output = '0';
        operator = '';
        num1 = 0;
        num2 = 0;
      } else if (value == '=') {
        num2 = double.parse(_input);

        if (operator == '+') {
          _output = (num1 + num2).toString();
        } else if (operator == '-') {
          _output = (num1 - num2).toString();
        } else if (operator == '*') {
          _output = (num1 * num2).toString();
        } else if (operator == '/') {
          _output = (num2 != 0) ? (num1 / num2).toString() : 'Undefined';
        }
        _input = _output;
      } else if (['+', '-', '*', '/'].contains(value)) {
        num1 = double.parse(_input);
        operator = value;
        _input = '';
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              color: Colors.white38,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              BuildButton(buttonText: '7', onClick: () => buttonPressed('7')),
              BuildButton(buttonText: '8', onClick: () => buttonPressed('8')),
              BuildButton(buttonText: '9', onClick: () => buttonPressed('9')),
              BuildButton(
                buttonText: '+',
                buttonColor: Colors.amber,
                onClick: () => buttonPressed('+'),
              ),
            ],
          ),
          Row(
            children: [
              BuildButton(buttonText: '4', onClick: () => buttonPressed('4')),
              BuildButton(buttonText: '5', onClick: () => buttonPressed('5')),
              BuildButton(buttonText: '6', onClick: () => buttonPressed('6')),
              BuildButton(
                buttonText: '-',
                buttonColor: Colors.amber,
                onClick: () => buttonPressed('-'),
              ),
            ],
          ),
          Row(
            children: [
              BuildButton(buttonText: '1', onClick: () => buttonPressed('1')),
              BuildButton(buttonText: '2', onClick: () => buttonPressed('2')),
              BuildButton(buttonText: '3', onClick: () => buttonPressed('3')),
              BuildButton(
                buttonText: '*',
                buttonColor: Colors.amber,
                onClick: () => buttonPressed('*'),
              ),
            ],
          ),
          Row(
            children: [
              BuildButton(
                buttonText: 'C',
                buttonColor: Colors.red,
                onClick: () => buttonPressed('C'),
              ),
              BuildButton(buttonText: '0', onClick: () => buttonPressed('0')),
              BuildButton(
                buttonText: '=',
                buttonColor: Colors.green,
                onClick: () => buttonPressed('='),
              ),
              BuildButton(
                buttonText: '/',
                buttonColor: Colors.amber,
                onClick: () => buttonPressed('/'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
