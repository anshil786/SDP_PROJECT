import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem6_sdp_erent/screens/home_page.dart';
import 'package:sem6_sdp_erent/screens/landing_page.dart';
import 'package:sem6_sdp_erent/screens/login_page.dart';
import 'package:sem6_sdp_erent/screens/placeOrder.dart';
import 'package:sem6_sdp_erent/screens/previousorder.dart';
import 'package:sem6_sdp_erent/screens/tandc.dart';

import 'screens/success.dart';
// import 'dart:html';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            accentColor: Color(0xFFFF1E00)),
        home: LandingPage(),
        routes: <String, WidgetBuilder>{
          'TandC': (BuildContext context) => TandC(),
          'PlaceOrder': (BuildContext context) => PlaceOrder(),
          'Success': (BuildContext context) => Success(),
          'homepage': (BuildContext context) => HomePage(),
          'PreviousOrder': (BuildContext context) => PreviousOrder(),
          'login': (BuildContext context) => LoginPage(),
        });
  }
}
