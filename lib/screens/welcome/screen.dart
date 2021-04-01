// native
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// application
import 'package:ctrl_fan_project/screens/auth/label.dart';
import 'package:ctrl_fan_project/screens/auth/login/screen.dart';
import 'package:ctrl_fan_project/screens/auth/signup/screen.dart';
import 'package:ctrl_fan_project/screens/auth/forgot/screen.dart';
import 'package:ctrl_fan_project/components/ui/popup/popup.dart';
import 'package:ctrl_fan_project/help/platform.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    final List<String> advanced = [
      "com.example.check",
    ];

    // for access context use schedule instance, or use Future
    // ```dart
    //  Future.delayed(Duration.zero,() {
    //    popup.show(context, ...);
    //  }
    // ```
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // call API
      // return checked apps
      // return banner message
      // return another
      PlatformHelper.isInstalledOneOfPackages(advanced).then((value) {
        if (value == false) {

          // check banner message exist
          // create custom banner^
          //  - message
          //  - update
          //  - warning and etc.
          final popup = BeautifulPopup(
            context: context,
            template: TemplateOrangeRocket2,
          );

          // example update message banner
          popup.show(
            title: 'Update',
            content: 'Dear user, we have a new update. Please update. We will stop supporting the current version in a few days. Thanks.',
            actions: [
              popup.button(
                label: 'Go to market',
                onPressed: () async {
                  setState(() {
                    isLoaded = true;
                  });

                  await Navigator.of(context).pop();
                },
              ),
            ],
            barrierDismissible: false,
            close: Container(),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2
                  )
                ],
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xfffbb448), Color(0xffe46b10)]
                )
            ),
            child: SingleChildScrollView(
              child: !isLoaded ? _splash(context) : _main(context),
            ),
          ),
        )
    );
  }
}

Widget _main(BuildContext context) {
  final height = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: height * .2),
      CtrlFanProjectLabel(context, false),
      SizedBox(
        height: 200,
      ),
      _submitButton(context),
      SizedBox(
        height: 20,
      ),
      _signUpButton(context),
      SizedBox(
        height: 10,
      ),
      _rightAlignLabel('Forgot password?', () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgotScreen()
        ));
      }),
      _rightAlignLabel('Add new device', () {
        // todo add device screen
      })
    ],
  );
}

Widget _splash(BuildContext context) {
  final height = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: height * .2),
      CtrlFanProjectLabel(context, false),
      SizedBox(
        height: 300,
      ),
      CircularProgressIndicator(
        backgroundColor: Colors.white,
        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfffbb448)),
      ),
      SizedBox(
        height: 10,
      ),
      Text("Loading...", style: TextStyle(
        fontStyle: Theme.of(context).textTheme.display1.fontStyle,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      )),
    ],
  );
}

Widget _submitButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()
      ));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xffdf8e33).withAlpha(100),
                offset: Offset(2, 4),
                blurRadius: 8,
                spreadRadius: 2
            )
          ],
          color: Colors.white
      ),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
      ),
    ),
  );
}

Widget _signUpButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpScreen()
      ));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        'Register now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget _rightAlignLabel(String label, Function onTab) {
  return InkWell(
    onTap: () {
      onTab();
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )
      ),
    ),
  );
}