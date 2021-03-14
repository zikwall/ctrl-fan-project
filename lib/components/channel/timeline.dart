import 'package:flutter/material.dart';
import 'package:ctrl_fan_project/help/math.dart';

Widget buildTimeline(double width, int current, int total) {
  return Container(
    alignment: Alignment.centerLeft,
    width: width,
    height: 2,
    color: Colors.grey[300],
    child: Container(
        width: width * floatPercent(current, total),
        height: 2,
        color: Color(0xfffbb448)
    ),
  );
}