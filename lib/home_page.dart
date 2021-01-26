import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double fontSize1 = 40.0;
  double fontSize2 = 30.0;
  String inputText = '0';
  String outputText = '0';
  String expression = '';
  void _inputManipulation(String input) {
    setState(() {
      if (input == 'C') {
        inputText = "0";
        outputText = '0';
        fontSize1 = 40.0;
        fontSize2 = 30.0;
      } else if (input == '<<<') {
        inputText == inputText.substring(0, 1);
        if (inputText == "") {
          inputText = '0';
        }
      } else if (input == '=') {
        print('=');
        fontSize1 = 30.0;
        fontSize2 = 40.0;
        expression = inputText;
        expression = expression.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          outputText = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (error) {
          outputText = 'Error';
        }
        inputText = "0";
      } else {
        if (inputText == "0") {
          inputText = input;
        } else {
          inputText = inputText + input;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(children: [
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              inputText,
              style: TextStyle(fontSize: fontSize1),
            )),
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              outputText,
              style: TextStyle(fontSize: fontSize2),
            )),
        Expanded(
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton(context, 'C', Colors.red),
                    buildButton(context, '<<<', Colors.blue),
                    buildButton(context, '/', Colors.blue),
                  ]),
                  TableRow(children: [
                    buildButton(context, '7', Colors.grey),
                    buildButton(context, '8', Colors.grey),
                    buildButton(context, '9', Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton(context, '4', Colors.grey),
                    buildButton(context, '5', Colors.grey),
                    buildButton(context, '6', Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton(context, '1', Colors.grey),
                    buildButton(context, '2', Colors.grey),
                    buildButton(context, '3', Colors.grey),
                  ]),
                  TableRow(children: [
                    buildButton(context, '.', Colors.grey),
                    buildButton(context, '0', Colors.grey),
                    buildButton(context, '00', Colors.grey),
                  ])
                ],
              ),
            ),
            Column(children: [
              buildButton(context, 'x', Colors.blue),
              buildButton(context, '-', Colors.blue),
              buildButton(context, '+', Colors.blue),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
                child: FlatButton(
                  onPressed: () {
                    _inputManipulation('=');
                  },
                  child: Text('=', style: TextStyle(color: Colors.white)),
                ),
              ),
            ])
          ],
        ),
      ]),
    );
  }

  Container buildButton(BuildContext context, String text, Color buttonColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: buttonColor,
        border: Border.all(
            color: Colors.white, width: 1.0, style: BorderStyle.solid),
      ),
      child: FlatButton(
        onPressed: () {
          _inputManipulation(text);
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
