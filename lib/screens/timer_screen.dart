import 'package:flutter/material.dart';

enum TimerStatus { running, paused, stopped, resting }

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreen createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  static const WORK_SECONDS = 25;
  static const REST_SECONDS = 5;

  late TimerStatus _timerStatus;
  late int _timer;
  late int _pomodoroCount;

  @override
  void initStatus() {
    super.initState();
    _timerStatus = TimerStatus.stopped;
    print(_timerStatus.toString());
    _timer = WORK_SECONDS;
    _pomodoroCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _runningButtons = [
      ElevatedButton(
        onPressed: () {},
        child: Text(
          1 == 2 ? '계속하기' : '일시정지',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      ),
      Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(
        onPressed: () {},
        child: Text(
          '포기하기',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      ),
    ];

    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        onPressed: () {},
        child: Text(
          '시작하기',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: 1 == 2 ? Colors.green : Colors.blue),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('뽀모도로 타이머'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Center(
              child: Text(
                '00:00',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: 1 == 2 ? Colors.green : Colors.blue),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 1 == 2
                ? const []
                : 1 == 2
                    ? _stoppedButtons
                    : _runningButtons,
          )
        ],
      ),
    );
  }

  void run() {
    setState(() {
      _timerStatus = TimerStatus.running;
      print("[=>] " + _timerStatus.toString());
      runTimer();
    });
  }

  void paused() {
    setState(() {
      _timerStatus = TimerStatus.paused;
      print("[=>] " + _timerStatus.toString());
    });
  }

  void resume() {
    run();
  }

  void rest() {
    setState(() {
      _timerStatus = TimerStatus.resting;
      _timer = REST_SECONDS;
      print("[=>] " + _timerStatus.toString());
    });
  }

  void stop() {
    setState(() {
      _timerStatus = TimerStatus.stopped;
      print("[=>] " + _timerStatus.toString());
    });
  }
}
