import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
   String display = '';
   double firstOperand = 0;
   double secondOperand = 0;
   String operator = '';

   void ButtonClick(String value){
    setState(() {
      if(value == '+' || value == '-'|| value =='/' || value == '*'){
        firstOperand = double.parse(display);
        operator = value;
        display = '';
      } else if (value == 'CE'){
        display = '';
        firstOperand= 0;
        secondOperand = 0;
        operator = '';
      } else if(value == '='){
        secondOperand = double.parse(display);
        display = calculate();
      } else {
        display += value;
      }
    });
   }
  String calculate(){
    double result = 0;
    switch(operator){
      case '+':
        result = firstOperand + secondOperand;
        break;
      case '-': 
        result = firstOperand - secondOperand;
        break;
      case '/':
        result = firstOperand / secondOperand;
        break;
      case '*':
        result = firstOperand * secondOperand;
        break;
    }
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: 
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Container(
                alignment: Alignment.centerRight,
                child: Text(display ,style: TextStyle(fontSize: 30),
                ),
              ),
              Expanded(child: Divider(),),
              buildButtonRows(['7','8','9','+']),
              buildButtonRows(['4','5','6','-']),
              buildButtonRows(['1','2','3','*']),
              buildButtonRows(['0','CE','=','/']),

            ],
          ),
        );
  }

  Widget buildButtonRows(List<String> button){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: button.map((label){
        return buildButton(label);
      }).toList(),
    );
  }
  Widget buildButton(String label){
    return Expanded (
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => ButtonClick(label), 
          child: Text(label, 
          style: TextStyle(fontSize: 20),
          )
        ),
       ),
     );
  }
}