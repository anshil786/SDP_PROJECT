//import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/screens/home_page.dart';
import 'package:sem6_sdp_erent/screens/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialaization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialaization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error:${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, streamsnapshot) {
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${streamsnapshot.error}"),
                  ),
                );
              }
              if (streamsnapshot.connectionState == ConnectionState.active) {
                Object? _user = streamsnapshot.data;
                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }
              return Scaffold(
                  body: Center(
                      child: Text("checking Authentication...",
                          style: Constants.regularHeading)));
            },
          );
        }
        return Scaffold(
            body: Center(
                child: Text("initialization App",
                    style: Constants.regularHeading)));
      },
    );
  }
}
