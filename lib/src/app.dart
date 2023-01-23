import './screen/home.dart';
import './screen/user/register.dart';
import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
class MyApp extends StatelessWidget {

  String? token;
  MyApp(this.token,{super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: (token==null)?Register():Home(),
    );
  }
}
