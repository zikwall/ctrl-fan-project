// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// dependencies
import 'package:better_player/better_player.dart';

// application
import 'package:ctrl_fan_project/constants/hls.dev.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ctrl Fan Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Ctrl Fan Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    BetterPlayerDataSourceType.network, exampleHls,
    notificationConfiguration: BetterPlayerNotificationConfiguration(
      showNotification: true,
      title: "Elephant dream",
      author: "Some author",
      imageUrl:"https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg",
    ),
  );

  var betterPlayerConfiguration = BetterPlayerConfiguration(
    autoPlay: true,
    looping: true,
    fullScreenByDefault: false,
  );

  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    _betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: dataSource
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(
                controller: _betterPlayerController,
              ),
            ),
          ),
        )
    );
  }
}
