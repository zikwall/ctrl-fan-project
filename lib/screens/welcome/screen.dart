// native
import 'dart:async';
import 'package:flutter/material.dart';

// application
import 'package:ctrl_fan_project/screens/auth/label.dart';
import 'package:ctrl_fan_project/screens/auth/login/screen.dart';
import 'package:ctrl_fan_project/screens/auth/signup/screen.dart';
import 'package:ctrl_fan_project/screens/auth/forgot/screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    // simulate call API
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return _splash(context);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 65,
              ),
              CtrlFanProjectLabel(context, false),
              SizedBox(
                height: 80,
              ),
              _submitButton(context),
              SizedBox(
                height: 20,
              ),
              _signUpButton(context),
              SizedBox(
                height: 20,
              ),
              _forgotButton(context),
              SizedBox(
                height: 10,
              ),
              _addDeviceButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _splash(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Center(
              child: CtrlFanProjectLabel(context, false),
            ),
            const Spacer(),
            new CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xfffbb448)),
            ),
            SizedBox(
              height: 10,
            ),
            new Text("Loading...", style: TextStyle(
              fontStyle: Theme.of(context).textTheme.display1.fontStyle,
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            )),
            const Spacer(),
          ],
        ),
      ),
    ),
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

Widget _forgotButton(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ForgotScreen()
      ));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Text(
        'Forgot password',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ),
  );
}

Widget _addDeviceButton(BuildContext context) {
  return InkWell(
    onTap: () {

    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
      ),
      child: Text(
        'Add device',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ),
  );
}