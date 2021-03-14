import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ctrl_fan_project/components/ui/image.dart';
import 'package:ctrl_fan_project/components/channel/timeline.dart';
import 'package:ctrl_fan_project/help/time.dart';

Widget buildChannelListItem(BuildContext context, int now, Map<String, dynamic> item) {
  DateTime start;
  DateTime stop;
  // magic sizes
  double width = MediaQuery.of(context).size.width * 0.65;

  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    width = MediaQuery.of(context).size.width * 0.83;
  }

  final List<Widget> items = <Widget>[
    Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: width,
        child: Text(
          item['channel_name'],
          overflow: TextOverflow.ellipsis,
          style: new TextStyle(
            color: Color(0xfffbb448),
            fontSize: 13.0,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        )
    ),
  ];

  Map<String, dynamic> current = item['programm_current'] ?? null;

  if (current != null) {
    if (current['begin'] is String) {
      current['begin'] = int.parse(current['begin']);
    }

    if (current['end'] is String) {
      current['end'] = int.parse(current['end']);
    }

    start = DateTime.fromMillisecondsSinceEpoch(getMilliseconds(current['begin']));
    stop = DateTime.fromMillisecondsSinceEpoch(getMilliseconds(current['end']));

    items.addAll(
        [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: width,
            child: Text(
              current['name'],
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: Color(0xfffbb448),
                fontSize: 10.0,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          buildTimeline(width, current['end'] - current['begin'], now - current['begin']),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "${DateFormat('kk:mm').format(start)} - ${DateFormat('kk:mm').format(stop)}",
              style: new TextStyle(
                color: Color(0xfffbb448),
                fontSize: 10.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]
    );
  }

  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.only(bottom: 5),
    child: Row(
      children: <Widget>[
        buildNetworkImage(item['channel_logo']),
        Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ...items,
              ],
            )
        )
      ],
    ),
  );
}