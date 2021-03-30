// native
import 'package:flutter/material.dart';

// dependencies
import 'package:timelines/timelines.dart';

List<_TimelineStatus> data = [
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.todo,
  _TimelineStatus.todo,
  _TimelineStatus.todo,
  _TimelineStatus.todo,
];

Widget timeline() {
  return Timeline.tileBuilder(
    theme: TimelineThemeData(
      nodePosition: 0,
      nodeItemOverlap: true,
      color: Color(0xfff7892b),
      connectorTheme: ConnectorThemeData(
        color: Color(0xff161b22),
        thickness: 15.0,
      ),
    ),
    padding: EdgeInsets.only(left: 20.0),
    builder: TimelineTileBuilder.connected(
      indicatorBuilder: (context, index) {
        final status = data[index];
        return OutlinedDotIndicator(
          color:
          status.isInProgress ? Color(0xfffbb448) : Color(0xffe6e7e9),
          backgroundColor:
          status.isInProgress ? Color(0xffd4f5d6) : Color(0xffc2c5c9),
          borderWidth: status.isInProgress ? 3.0 : 2.5,
        );
      },
      connectorBuilder: (context, index, connectorType) {
        var color;

        color = data[index].isInProgress ? Color(0xfff7892b) : null;

        return SolidLineConnector(
          color: color,
        );
      },
      contentsBuilder: (context, index) {
        return Container(
          alignment: Alignment.centerLeft,
          color: Color(0xff161b22),
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  _timecode('00:00'),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  _timecode('00:00')
                ],
              ),
              VerticalDivider(
                color: Colors.grey,
              ),
              Text('Timeline Event $index', style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      },
      itemCount: data.length,
      contentsAlign: ContentsAlign.basic,
    ),
  );
}

Widget _timecode(String time) {
  return Text(
      time,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      )
  );
}

enum _TimelineStatus {
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}

List<Widget> buildTimelineTabs(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return <Widget>[
    Container(
      color: Color(0xff161b22),
      child: TabBar(
          labelColor: Color(0xfff7892b),
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            //borderRadius: BorderRadius.circular(5),
            color: Color(0xff0d1117),
          ),
          isScrollable: true,
          tabs: [1, 2, 3, 4, 5, 6, 7].map((e) =>
              _buildTab("0$e-01", width * 0.05)
          ).toList()
      ),
    ),
    Expanded(
      flex: 1,
      child: TabBarView(children: [
        timeline(),
        timeline(),
        timeline(),
        timeline(),
        timeline(),
        timeline(),
        timeline(),
      ]),
    ),
  ];
}

Widget _buildTab(String label, double size) {
  return Tab(
    child: Container(
      width: 100,
      child: Align(
        alignment: Alignment.center,
        child: Text(label),
      ),
    ),
  );
}