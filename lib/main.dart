import 'package:finalx/screens/begin_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinalX',
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[100]),
      home: BeginScreen(),
    );
  }
}
