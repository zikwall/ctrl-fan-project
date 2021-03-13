// native
import 'package:flutter/material.dart';

// dependencies
import 'package:google_fonts/google_fonts.dart';

Widget CtrlFanProjectLabel(BuildContext context, bool invert) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'Ct',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.display1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: invert ? Color(0xffe46b10) : Colors.white,
        ),
        children: [
          TextSpan(
            text: 'rl',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'fan',
            style: TextStyle(color:invert ? Color(0xffe46b10) : Colors.white, fontSize: 30),
          ),
          TextSpan(
            text: 'pr',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: 'oje',
            style: TextStyle(color: invert ? Color(0xffe46b10) : Colors.white, fontSize: 30),
          ),
          TextSpan(
            text: 'ct',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ]),
  );
}