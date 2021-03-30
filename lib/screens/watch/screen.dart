// native

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:better_player/better_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:timelines/timelines.dart';

// application
import 'package:ctrl_fan_project/constants/hls.dev.dart';
import 'package:ctrl_fan_project/help/string.dart';

class WatchScreen extends StatefulWidget {
  final Map<String, dynamic> channel;

  WatchScreen({
    Key key,
    @required this.channel
  }) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  GlobalKey _betterPlayerKey = GlobalKey();

  var betterPlayerConfiguration = BetterPlayerConfiguration(
    fit: BoxFit.contain,
    autoDetectFullscreenDeviceOrientation: true,
    autoPlay: true,
    looping: true,
    fullScreenByDefault: false,
    allowedScreenSleep: false,
    controlsConfiguration:
    BetterPlayerControlsConfiguration(
      playerTheme: BetterPlayerTheme.cupertino,
    ),
  );

  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      base64decode(widget.channel['stream_link'].toString().substring(3)),
      liveStream: true,
      /*notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: "Elephant dream",
        author: "Some author",
        imageUrl:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg",
      ),*/
    );

    _betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: dataSource
    );

    Wakelock.enable();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    Wakelock.disable();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: DefaultTabController(
          length: 7,
          child: Scaffold(
              body: Container(
                color: Color(0xff0d1117),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: statusBarHeight,
                  ),
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: _betterPlayerController,
                          key: _betterPlayerKey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () {
                            _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
                          },
                          child: Text("Enter to PIP", style: TextStyle(color: Color(0xfff7892b))),
                        ),
                      ),
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
                            tabs: [1, 2, 3, 4, 5, 6, 7].map((e) {
                              return _buildTab("0$e-01", width * 0.05);
                            }).toList()
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TabBarView(children: [
                          _timeline(),
                          _timeline(),
                          _timeline(),
                          _timeline(),
                          _timeline(),
                          _timeline(),
                          _timeline(),
                        ]),
                      )
                    ],
                  ),
                ),
              )
          ),
        )
    );
  }
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

Widget _timeline() {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Timeline Event $index', style: TextStyle(color: Colors.white)),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                    '0$index:05-0$index:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    )
                ),
              )
            ],
          ),
        );
      },
      itemCount: data.length,
      contentsAlign: ContentsAlign.basic,
    ),
  );
}

enum _TimelineStatus {
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}