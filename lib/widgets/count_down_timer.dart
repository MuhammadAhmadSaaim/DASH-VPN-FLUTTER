import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final bool startTimer;

  const CountDownTimer({super.key, required this.startTimer});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration = Duration();
  Timer? _timer;

  startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration=Duration(seconds: _duration.inSeconds+1);
      });
    });
  }

  stopTimer(){
    setState(() {
      _timer?.cancel();
      _timer=null;
      _duration=Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_timer==null || !widget.startTimer){
      widget.startTimer ? startTimer() : stopTimer();
    }

    String twoDigit(int n)=>n.toString().padLeft(2,'0');

    final seconds = twoDigit(_duration.inSeconds.remainder(60));
    final minutes = twoDigit(_duration.inMinutes.remainder(60));
    final hours = twoDigit(_duration.inHours);

    return  Text("$hours:$minutes:$seconds",style: TextStyle(fontSize: 22,));
  }
}
