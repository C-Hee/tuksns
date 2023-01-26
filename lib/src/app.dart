import 'package:sns_flutter/src/screen/user/login.dart';
import './screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
  String? token = '';
  MyApp(this.token, {super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token == null) ? Login() : Home(),
    );
  }
}
