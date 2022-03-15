// ignore_for_file: prefer_const_constructors

import 'package:cothinker/constants.dart';
import 'package:cothinker/screens/calender_screen.dart';
import 'package:cothinker/screens/header_screen.dart';
import 'package:cothinker/screens/header_calender_screen.dart';
import 'package:cothinker/screens/pill_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBgColor,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(child: HeaderScreen(), flex: 15),
            Expanded(child: PillScreen(), flex: 25),
            Expanded(child: HeaderCalenderScreen(), flex: 13),
            Expanded(
              child: CalenderScreen(),
              flex: 100,
            )
          ],
        )));
  }
}
