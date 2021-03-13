// native
import 'package:ctrl_fan_project/screens/welcome/screen.dart';

// dependencies
import 'package:google_fonts/google_fonts.dart';

// application
import 'package:flutter/material.dart';

void main() {
  runApp(CtrlFanApplication());
}

class CtrlFanApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Ctrl Fan Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
