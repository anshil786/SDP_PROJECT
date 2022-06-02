import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/product_page.dart';

import '../services/firebase_services.dart';
import '../widgets/custom_actionbar.dart';
import 'detailedOrder.dart';

class PreviousOrder extends StatefulWidget {
  final String? userId;
  final String? username;

  PreviousOrder({this.userId, this.username});
  @override
  State<PreviousOrder> createState() => _PreviousOrderState();
}

class _PreviousOrderState extends State<PreviousOrder> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(widget.userId)
                .collection("Details")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: Text('Loading...'),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return !snapshot.data!.docs.isNotEmpty
                    ? Center(
                        child:
                            Container(height: 200, child: Text('NO orders!')),
                      )
                    : Container(
                        // height: 200,
                        child: ListView(
                          padding: EdgeInsets.only(
                            top: 108.0,
                            bottom: 24.0,
                          ),
                          children: snapshot.data!.docs.map((document) {
                            return GestureDetector(
                              onTap: () {},
                              child: FutureBuilder<DocumentSnapshot>(
                                future: _firebaseServices.userRef
                                    .doc(widget.userId)
                                    .collection("Details")
                                    .doc(document.id)
                                    .get(),
                                builder: (ctx, sShot) {
                                  if (sShot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Scaffold(
                                      body: Center(
                                        child: Text('Loading...'),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Scaffold(
                                      body: Center(
                                        child: Text("Error:${snapshot.error}"),
                                      ),
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    // print(sShot.data!.id);
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  detailedOrder(
                                                userId:
                                                    widget.userId.toString(),
                                                email: sShot.data!.get('email'),
                                                date: sShot.data!.get('date'),
                                                deliveryAddress: sShot.data!
                                                    .get('deliveryaddress'),
                                                firstName: sShot.data!
                                                    .get('firstname'),
                                                lastName:
                                                    sShot.data!.get('lastname'),
                                                mobileNumber: sShot.data!
                                                    .get('mobilenumber'),
                                                numberofDays:
                                                    sShot.data!.get('Days'),
                                                orderId: sShot.data!.id,
                                                pinCode:
                                                    sShot.data!.get('pincode'),
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.black),
                                        margin: EdgeInsets.only(
                                            top: 20, left: 20, right: 20),
                                        height: 50,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          'On ' + sShot.data!.get('date'),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                  return Scaffold(
                                    body: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      );
              }

              // Loading State
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          CustomActionBar(
            hasbackArrow: true,
            title: widget.username.toString() + "'s Orders",
          ),
        ],
      ),
    );
  }
}
