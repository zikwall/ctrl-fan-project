// native
import 'package:ctrl_fan_project/help/platform.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// application
import 'package:ctrl_fan_project/screens/watch/screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool installedFromMarket = false;

  @override
  void initState() {
    super.initState();
    check();
  }

  void check() async {
    bool state = await PlatformHelper.isInstalledFromMarket();
    setState(() {
      installedFromMarket = state;
    });
  }

  @override
  void dispose() {
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
            body: Padding(
              padding: EdgeInsets.only(
                top: statusBarHeight,
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => WatchScreen()
                    ));
                  },
                  child: Text("Watch, ${installedFromMarket ? " original" : "crack"}"),
                ),
              ),
            )
        )
    );
  }
}
