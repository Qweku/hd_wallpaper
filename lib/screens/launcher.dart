// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import 'homeScreen.dart';


class Launcher extends StatefulWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: 0.8).animate(_controller);
    _controller.forward();
    startTime();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 15, 19),
        body: Stack(
          children: [
            ScaleTransition(
              scale:_animation,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.white)),
                  child: FadeTransition(
                    opacity: _animation,
                    child: Image.asset('assets/logo-white.png',)
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment(0, 0.9),
              child: Text('@ c r e a t e d b y Q w e k u',
                  style: TextStyle(color:Colors.white,fontSize:12)),
            )
          ],
        ));
  }
}
