// native
import 'package:ctrl_fan_project/help/platform.dart';
import 'package:ctrl_fan_project/screens/auth/forgot/screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// application
import 'package:ctrl_fan_project/screens/auth/signup/screen.dart';
import 'package:ctrl_fan_project/screens/auth/container.dart';
import 'package:ctrl_fan_project/screens/auth/label.dart';
import 'package:ctrl_fan_project/screens/home/screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer()
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        CtrlFanProjectLabel(context, true),
                        SizedBox(height: 50),
                        _emailPasswordWidget(),
                        SizedBox(height: 20),
                        _submitButton(context),
                        SizedBox(height: height * .18),
                        _createAccountLabel(context),
                        _forgotPasswordLabel(context),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton(context)),
              ],
            ),
          )
      )
    );
  }
}

Widget _backButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
          )
        ],
      ),
    ),
  );
}

Widget _entryField(String title, {bool isPassword = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true
            )
        )
      ],
    ),
  );
}

Widget _submitButton(BuildContext context) {
  return InkWell(
    onTap: () async {
      DeviceInformation info = await PlatformHelper.getInfo();

      print("${info.DeviceId}, ${info.model}, ${info.device}, ${ info.Release}");

      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen())
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2
            )
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)]
          )
      ),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget _createAccountLabel(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUpScreen()
      ));
    },
    child: Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _forgotPasswordLabel(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ForgotScreen()
      ));
    },
    child: Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot Password ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Recover',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _emailPasswordWidget() {
  return Column(
    children: <Widget>[
      _entryField("Email id"),
      _entryField("Password", isPassword: true),
    ],
  );
}