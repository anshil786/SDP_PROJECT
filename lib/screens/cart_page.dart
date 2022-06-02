//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/screens/product_page.dart';
import 'package:sem6_sdp_erent/screens/tandc.dart';
import 'package:sem6_sdp_erent/services/firebase_services.dart';
import 'package:sem6_sdp_erent/widgets/custom_actionbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef
                .doc(_firebaseServices.getUserId())
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 24.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productId: document.id,
                              ),
                            ));
                      },
                      child: FutureBuilder(
                        future:
                            _firebaseServices.productRef.doc(document.id).get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> productSnap) {
                          //List _productMap =  [];
                          if (productSnap.hasError) {
                            return Container(
                              child:
                                  Center(child: Text("${productSnap.error}")),
                            );
                          }
                          if (productSnap.connectionState ==
                              ConnectionState.done) {
                            Map _productMap = productSnap.data!.data();
                            return Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 115,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          "${_productMap['images'][0]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 16),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Text(
                                                "${_productMap['name']}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4),
                                                  child: Text(
                                                    "${_productMap['price']}" +
                                                        " Rs/day",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Size - ${document.data()['size']}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 190),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _firebaseServices.userRef
                                                          .doc(_firebaseServices
                                                              .getUserId())
                                                          .collection("Cart")
                                                          .doc(document.id)
                                                          .delete();
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // FlatButton(
                              //   color: Colors.black,
                              //   textColor: Colors.white,
                              //   onPressed: () {},
                              //   child: Text("Proceed"),
                              //   minWidth: 200,
                              //   height: 40,
                              // ),
                            ]);
                          }
                          return Container(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                      ),
                    );
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
            hasbackArrow: true,
            title: "Cart",
          ),
          Container(
            alignment: Alignment.bottomCenter,
            //width: double.infinity,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(200),
            // ),

            child: FlatButton(
              color: Colors.black,
              textColor: Colors.white,
              splashColor: Color(0xFFFF1E00),
              onPressed: () => Navigator.pushNamed(context, 'TandC'),
              child: Text("Proceed"),
              minWidth: 200,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
