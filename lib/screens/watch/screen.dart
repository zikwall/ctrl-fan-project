// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:better_player/better_player.dart';
import 'package:wakelock/wakelock.dart';

// application
import 'package:ctrl_fan_project/constants/hls.dev.dart';

class WatchScreen extends StatefulWidget {
  WatchScreen({Key key}) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  GlobalKey _betterPlayerKey = GlobalKey();

  BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    BetterPlayerDataSourceType.network,
    exampleHls,
    liveStream: true,
    notificationConfiguration: BetterPlayerNotificationConfiguration(
      showNotification: true,
      title: "Elephant dream",
      author: "Some author",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg",
    ),
  );

  var betterPlayerConfiguration = BetterPlayerConfiguration(
    autoPlay: true,
    looping: true,
    fullScreenByDefault: false,
    allowedScreenSleep: false,
  );

  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

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

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
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
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}
