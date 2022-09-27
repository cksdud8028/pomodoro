import 'package:flutter/material.dart';
import 'package:pomodoro/screens/timer_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer App',
      home: TimerScreen(),
    );
  }
}
