import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/cart_page.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/services/firebase_services.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasbackArrow;
  final bool? hasTitle;
  final bool? hasbackground;
  CustomActionBar(
      {this.title, this.hasbackArrow, this.hasTitle, this.hasbackground});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _UserRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasbackArrow = hasbackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasbackground = hasbackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasbackground
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 57.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_hasbackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/left-arrow.png"),
                  color: Colors.white,
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            ),
          SizedBox(
            width: 30,
          ),
          if (_hasTitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
              textAlign: TextAlign.center,
            ),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => CartPage()));
          //   },
          //   child: Container(
          //       width: 42.0,
          //       height: 42.0,
          //       decoration: BoxDecoration(
          //           color: Colors.black,
          //           borderRadius: BorderRadius.circular(8.0)),
          //       alignment: Alignment.center,
          //       child: StreamBuilder(
          //         stream: _UserRef.doc(_firebaseServices.getUserId())
          //             .collection("Cart")
          //             .snapshots(),
          //         builder: (BuildContext context, AsyncSnapshot snapshot) {
          //           int _totalitems = 0;

          //           if (snapshot.connectionState == ConnectionState.active) {
          //             List _documents = snapshot.data!.docs;
          //             _totalitems = _documents.length;
          //           }

          //           return Text(
          //             "$_totalitems",
          //             style: TextStyle(
          //               fontSize: 18.0,
          //               fontWeight: FontWeight.w600,
          //               color: Colors.white,
          //             ),
          //           );
          //         },
          //       )),
          // )
        ],
      ),
    );
  }
}
