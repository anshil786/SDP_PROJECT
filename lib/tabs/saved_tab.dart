import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/services/firebase_services.dart';
import 'package:sem6_sdp_erent/widgets/custom_actionbar.dart';

import '../screens/previousorder.dart';
import '../screens/product_page.dart';

class SavedTab extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("Users").get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                snapshot.data!.docs.forEach(
                  (element) {
                    print(element.get('name'));
                  },
                );
                print(snapshot.data!.docs);
                return !snapshot.data!.docs.isNotEmpty
                    ? Center(
                        child: Container(
                            height: 200, child: Text('not yet any users!')),
                      )
                    : ListView(
                        padding: EdgeInsets.only(
                            top: 108.0, bottom: 24.0, left: 10, right: 10),
                        children: snapshot.data!.docs.map((document) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PreviousOrder(
                                        userId: document.id,
                                        username: document.get('name'),
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 191, 189, 189)),
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, right: 20),

                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                // decoration: BoxDecoration(
                                //     ),
                                // alignment: Alignment.centerLeft,
                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  document.get('name'),
                                  style: Constants.regularDarkText,
                                ),
                              ));
                        }).toList(),
                      );
              }
              // Loading State
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          CustomActionBar(
            title: "Orders",
            hasbackArrow: false,
          ),
        ],
      ),
    );
  }
}
