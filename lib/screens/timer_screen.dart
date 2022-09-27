import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

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
        onPressed: _timerStatus == TimerStatus.paused ? resume : paused,
        child: Text(
          _timerStatus == TimerStatus.paused ? '계속하기' : '일시정지',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      ),
      Padding(padding: EdgeInsets.all(20)),
      ElevatedButton(
        onPressed: stop,
        child: Text(
          '포기하기',
          style: TextStyle(fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      ),
    ];

    final List<Widget> _stoppedButtons = [
      ElevatedButton(
        onPressed: run,
        child: Text(
          '시작하기',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: _timerStatus == TimerStatus.resting
                ? Colors.green
                : Colors.blue),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('뽀모도로 타이머'),
        backgroundColor:
            _timerStatus == TimerStatus.resting ? Colors.green : Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Center(
              child: Text(
                secondToString(_timer),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _timerStatus == TimerStatus.resting
                    ? Colors.green
                    : Colors.blue),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _timerStatus == TimerStatus.resting
                ? const []
                : _timerStatus == TimerStatus.stopped
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
      _timer = WORK_SECONDS;
      print("[=>] " + _timerStatus.toString());
    });
  }

  void runTimer() async {
    Timer.periodic(Duration(seconds: 1), (t) {
      switch (_timerStatus) {
        case TimerStatus.paused:
          t.cancel();
          break;
        case TimerStatus.stopped:
          t.cancel();
          break;
        case TimerStatus.running:
          if (_timer <= 0) {
            print("작업 완료!");
            rest();
          } else {
            setState(() {
              _timer -= 1;
            });
          }
          break;
        case TimerStatus.resting:
          if (_timer <= 0) {
            setState(() {
              _pomodoroCount += 0;
            });
            print("오늘 $_pomodoroCount개의 뽀모도로를 달성했습니다.");
            t.cancel();
            stop();
          } else {
            setState(() {
              _timer -= 1;
            });
          }
          break;
        default:
      }
    });
  }

  String secondToString(int second) {
    return sprintf("%02d:%02d", [second ~/ 60, second % 60]);
  }
}
