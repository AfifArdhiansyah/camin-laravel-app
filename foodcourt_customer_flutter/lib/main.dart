import 'package:flutter/material.dart';
import 'package:foodcourt_customer_flutter/menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Foodcourt',
      theme: ThemeData(
        primarySwatch: Colors.green,
        // textTheme: Theme.of(context).textTheme.apply(
        //   fontSizeFactor: 1.1,
        // ),
      ),
      home: MenuScreen(),
    );
  }
}