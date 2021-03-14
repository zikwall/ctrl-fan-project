// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// application
import 'package:ctrl_fan_project/screens/watch/screen.dart';
import 'package:ctrl_fan_project/components/bottom/navigation_bar.dart';
import 'package:ctrl_fan_project/components/bottom/navigation_bar_item.dart';
import 'package:ctrl_fan_project/help/time.dart';
import 'package:ctrl_fan_project/components/channel/item.dart';
import 'package:ctrl_fan_project/fetchers/streams.dart';
import 'package:ctrl_fan_project/help/platform.dart';
import 'package:ctrl_fan_project/screens/home/search.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Streams> futureStreams;
  bool installedFromMarket = false;

  @override
  void initState() {
    super.initState();
    check();
    futureStreams = fetchStreams();
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
    final int now = getNowTimestamp().toInt();

    final Widget Home = FutureBuilder<Streams>(
      future: futureStreams,
      builder: (BuildContext context, AsyncSnapshot<Streams> snapshot) {
        if (snapshot.hasData) {
          return _buildAnimatedChannelList(now, snapshot.data.channels);
        } else if (snapshot.hasError) {
          // try again
        }

        return _buildLoadingIndicator(context);
      },
    );

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
                    SearchWidget(
                        onCancel: () {},
                        onSearch: (value) {}
                    ),
                    Expanded(
                      child: Home,
                    )
                  ],
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

Widget _buildLoadingIndicator(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfffbb448)),
      ),
      SizedBox(
        height: 30,
      ),
      Text("Loading...", style: TextStyle(
        fontStyle: Theme.of(context).textTheme.display1.fontStyle,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Color(0xfffbb448),
      ))
    ],
  );
}

Widget _buildAnimatedChannelList(int now, List<dynamic> channels) {
  return AnimationLimiter(
    child: ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.0,  vertical: 10),
      itemCount: channels.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            child: FadeInAnimation(
              child: _buildChannel(context, now, channels[index]),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildChannel(BuildContext context, int now, Map<String, dynamic> channel) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WatchScreen(channel: channel)
      ));
    },
    child: buildChannelListItem(context, now, channel),
  );
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