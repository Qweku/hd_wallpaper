// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 15, 19),
        body: Stack(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.white)),
                child: FadeTransition(
                  opacity: _animation,
                  child: Image.asset('assets/logo-white.png',height:height*0.15)
                ),
              ),
            ),
            Container(
              alignment: Alignment(0, 0.9),
              child: Text('@ c r e a t e d b y Q w e k u',
                  style: TextStyle(color:Colors.white,fontSize:14)),
            ),
            Positioned(
              bottom:height*0.05,
              left:-width*0.4,
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                height:height*0.4,
                width: width*0.5,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  color:theme.primaryColorDark,
                  boxShadow:[
                    BoxShadow(
                      offset:Offset(0,-4),
                      color:Colors.black,
                      blurRadius: 1,
                      //spreadRadius: 1,
                    )
                  ]
                )
                          ),
              )),
           Positioned(
              top:height*0.05,
              right:-width*0.4,
              child: Transform.rotate(
                angle: pi / 4,
                child: Container(
                height:height*0.4,
                width: width*0.5,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  color:theme.primaryColorDark,
                  boxShadow:[
                    BoxShadow(
                      offset:Offset(0,4),
                      color:Colors.black,
                      blurRadius: 1,
                      //spreadRadius: 1,
                    )
                  ]
                )
                          ),
              ))
        
          ],
        ));
  }
}
