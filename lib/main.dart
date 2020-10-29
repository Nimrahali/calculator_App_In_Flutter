import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}
class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.purple),
      home:  simpleCalculator(
      ),
    );
  }
}

class simpleCalculator extends StatefulWidget {
  @override
  _simpleCalculatorState createState() => _simpleCalculatorState();
}

class _simpleCalculatorState extends State<simpleCalculator> {
  //variables
  String result = "0";
  String equation = "0";
  String expression = "0";
  double eqFontSize = 20.0;
  double resultFontSize = 25.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        eqFontSize = 20.0;
       resultFontSize = 25.0;

      }
      else if(buttonText == "DEL"){
        eqFontSize = 25.0;
        resultFontSize = 20.0;
         equation = equation.substring(0, equation.length -1);
         if( equation == ""){
           equation = "0";
         }
      }
      else if(buttonText == "="){
        eqFontSize = 20.0;
        resultFontSize = 25.0;
        expression = equation;
        expression = expression.replaceAll('×','*');
        expression = expression.replaceAll('÷','/');
        try{
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "ERROR";
        }

      }
      else {
        eqFontSize = 25.0;
        resultFontSize = 20.0;
        if (equation == "0") {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }

    } );
  }
  Widget buildButton( String buttonText, double buttonHeight, Color buttonColor){

   return Container(
      height:  MediaQuery.of(context).size.height * 0.1 * buttonHeight ,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 0.5,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed:() => buttonPressed(buttonText),
          child: Text(buttonText,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Raleway',
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal),
          )

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculator',  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, fontFamily: 'Raleway',color: Colors.white, fontStyle: FontStyle.italic,),),),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Text(equation, style: TextStyle(fontSize: eqFontSize, fontFamily: 'Raleway'),),),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: Text(result, style: TextStyle(fontSize: resultFontSize, fontFamily: 'Raleway'),),
          ),
          Expanded(child: Divider(),),

          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              //Row Container Starts.
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                      buildButton("C", 1, Colors.purple),
                      buildButton("DEL", 1, Colors.purpleAccent),
                      buildButton("%", 1, Colors.purpleAccent),
                      ]
                    ),
                    TableRow(
                      children: [
                      buildButton("7", 1, Colors.black54),
                      buildButton("8", 1, Colors.black54),
                      buildButton("9", 1, Colors.black54),
                      ]
                    ),
                     TableRow(
                      children: [
                      buildButton("4", 1, Colors.black54),
                      buildButton("5", 1, Colors.black54),
                      buildButton("6", 1, Colors.black54),
                      ]
                    ),
                    TableRow(
                      children: [
                      buildButton("1", 1, Colors.black54),
                      buildButton("2", 1, Colors.black54),
                      buildButton("3", 1, Colors.black54),
                      ]
                    ),
                    TableRow(
                      children: [
                      buildButton(".", 1, Colors.black54),
                      buildButton("0", 1, Colors.black54),
                      buildButton("00", 1, Colors.black54),
                      ]
                    ),

                  ],
                ),
              ),
              //Row Container Ends.
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children:[
                        buildButton("÷", 1, Colors.purpleAccent),
                      ]
                    ),
                    TableRow(
                      children:[
                        buildButton("×", 1, Colors.purpleAccent),
                      ]
                    ),
                    TableRow(
                      children:[
                        buildButton("-", 1, Colors.purpleAccent),
                      ]
                    ),
                      TableRow(
                      children:[
                        buildButton("+", 1, Colors.purpleAccent),
                      ]
                    ),
                      TableRow(
                      children:[
                        buildButton("=", 1, Colors.purpleAccent),
                      ]
                    ),


                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
