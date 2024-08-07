// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: 70,
      child:Stack(
        children: [
          Positioned(
            top: 12.5,
            left: 5,
            child: SvgPicture.asset(
              'assets/icons/logo/part1_white.svg', 
              height: 45, 
              fit: BoxFit.contain, 
            )
          ),

          Positioned(
            top: 15,
            left: 65,
            child: SvgPicture.asset(
              'assets/icons/logo/part2_white.svg', 
            height: 40, 
            fit: BoxFit.contain, 
            )
          )

        ],
      )
    );

  }
}

