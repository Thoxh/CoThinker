import 'package:cothinker/constants.dart';
import 'package:flutter/material.dart';

class DueTitle extends StatelessWidget {
  final String name;
  const DueTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }
}
