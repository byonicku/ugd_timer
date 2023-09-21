import 'dart:async';

import 'package:flutter/material.dart';

class TimerManager extends ChangeNotifier {
  Color _currentAccent = Colors.blue;
  Duration _displayTimer = Duration(seconds: 0); // for displaying the countdown
  Duration _duration = Duration(seconds: 0); // for displaying the countdown
  Duration _endAt = Duration(seconds: 0); // for the time where countdown ends
  Duration _assistTimer = Duration(seconds: 0); // for the time where people can ask
  bool _timerIsRunning = false;

  void setEndTimer(TimeOfDay? newEndTimer) {
    _endAt = Duration(hours: newEndTimer!.hour, minutes: newEndTimer.minute, seconds: 0);
    print("End hour: ${_endAt.inHours}, End minute: ${_endAt.inMinutes.remainder(60)}");
    notifyListeners();
  }

  void setAssistTimer(Duration newAssistTimer) {
    _assistTimer = newAssistTimer;
    notifyListeners();
  }

  void toggleTimer() {
    if (_timerIsRunning) {
      _timerIsRunning = false;
    } else {
      _timerIsRunning = true;
      _duration = _endAt - Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second);
      timerCounterdown();
    }
  }

  void changeAccent() async {
    if (_displayTimer.inSeconds >= _duration.inSeconds * 0.75) {
      _currentAccent = Colors.blue;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.5) {
      _currentAccent = Colors.green;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.25) {
      _currentAccent = Colors.yellow;
      notifyListeners();
      return;
    } else if (_displayTimer.inSeconds >= _duration.inSeconds * 0.1) {
      _currentAccent = Colors.red;
      notifyListeners();
      return;
    }
  }

  void timerCounterdown() async {
    print("Timer started");

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerIsRunning && _displayTimer.inSeconds >= 0) {
        _displayTimer = _endAt - Duration(hours: DateTime.now().hour, minutes: DateTime.now().minute, seconds: DateTime.now().second);
        changeAccent();
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  Color get currentAccent => _currentAccent;

  Duration get displayTimer => _displayTimer;

  Duration get endAt => _endAt;

  Duration get assistTimer => _assistTimer;

  bool get timerIsRunning => _timerIsRunning;
}
