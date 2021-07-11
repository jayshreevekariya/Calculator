import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Calc(),
    );
  }
}

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 20.0;
  double resultFontSize = 50.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 20.0;
        resultFontSize = 50.0;
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
          equationFontSize = 50.0;
          resultFontSize = 20.0;
        }
      } else if (buttonText == "=") {
        equationFontSize = 20.0;
        resultFontSize = 50.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 50.0;
        resultFontSize = 20.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      padding: EdgeInsets.all(4.0),
      //color: Colors.white,
      child: ElevatedButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20, color: textColor),
        ),
        onPressed: () => buttonPressed(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: CircleBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          //color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    "assets/icons/menu.svg",
                    height: 30,
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Calculator"),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.white,
                      backgroundColor: Color(0xFF088F62),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Converter"),
                    style: TextButton.styleFrom(
                      primary: Colors.black38,
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/moon.svg",
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding: EdgeInsets.all(20),
                // height: 200,
                // width: 500,
                // color: Colors.grey,
                alignment: Alignment.centerRight,
                child: Text(
                  equation,
                  style: TextStyle(
                    fontSize: equationFontSize,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                //color: Colors.grey,
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: resultFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //Spacer(),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1, Colors.green),
                        buildButton("⌫", 1, Colors.green),
                        buildButton("%", 1, Colors.green),
                        buildButton("÷", 1, Colors.green),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black),
                        buildButton("8", 1, Colors.black),
                        buildButton("9", 1, Colors.black),
                        buildButton("×", 1, Colors.green),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black),
                        buildButton("5", 1, Colors.black),
                        buildButton("6", 1, Colors.black),
                        buildButton("-", 1, Colors.green),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black),
                        buildButton("2", 1, Colors.black),
                        buildButton("3", 1, Colors.black),
                        buildButton("+", 1, Colors.green),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("0", 1, Colors.black),
                        buildButton("00", 1, Colors.black),
                        buildButton(".", 1, Colors.black),
                        buildButton("=", 1, Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
