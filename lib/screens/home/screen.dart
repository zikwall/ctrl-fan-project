// native
import 'package:ctrl_fan_project/help/platform.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// application
import 'package:ctrl_fan_project/screens/watch/screen.dart';
import 'package:ctrl_fan_project/components/bottom/navigation_bar.dart';
import 'package:ctrl_fan_project/components/bottom/navigation_bar_item.dart';

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
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => WatchScreen()
                      ));
                    },
                    child: Text(
                        "Watch, ${installedFromMarket ? " original" : "crack"}",
                      style: TextStyle(color: Color(0xfff7892b)),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: TitledBottomNavigationBar(
                currentIndex: 0,
                backgroundColor: Color(0xff0d1117),
                indicatorColor: Color(0xfff7892b),
                inactiveStripColor: Color(0xff0d1117),
                activeColor: Color(0xfff7892b),
                onTap: (index){
                  print("Selected Index: $index");
                },
                items: [
                  _bottomItem('Home', Icons.home),
                  _bottomItem('Search', Icons.search),
                  _bottomItem('IPTV', Icons.data_usage),
                  _bottomItem('Menu', Icons.menu),
                ]
            )
        )
    );
  }
}

TitledNavigationBarItem _bottomItem(String title, IconData icon) {
  return TitledNavigationBarItem(
      title: Text(title, style: TextStyle(
        color: Color(0xfff7892b),
      )),
      icon: icon,
      backgroundColor: Color(0xff0d1117),
  );
}