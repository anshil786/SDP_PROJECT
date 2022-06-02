//import 'dart:html';
//import 'dart:html';

//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/services/firebase_services.dart';
import 'package:sem6_sdp_erent/widgets/custom_actionbar.dart';
import 'package:sem6_sdp_erent/widgets/image_swipe.dart';
import 'package:sem6_sdp_erent/widgets/product_sizes.dart';

class ProductPage extends StatefulWidget {
  final String? productId;
  ProductPage({this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future _addToCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToSaved() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future _addToOrder() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Order")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }

  Future outofstock() async {
    await _firebaseServices.productRef.doc(_firebaseServices.getProductId())
        // .collection("Products")
        //.doc(widget.productId)
        .update({"status": 'out of stock'});
  }

  Future instock() async {
    await _firebaseServices.userRef.doc(_firebaseServices.getProductId())
        // .collection("Products")
        // .doc(widget.productId)
        .update({"status": 'in stock'});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Status Updated"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productRef.doc(widget.productId).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                DocumentSnapshot documentData = snapshot.data!;
                //Different Images
                List imageList = documentData['images'];
                List productSizes = documentData['size'];
                String x = documentData['status'];

                _selectedProductSize = productSizes[0].toString();
                return ListView(
                  padding: EdgeInsets.only(top: 45),
                  children: [
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 24.0,
                        bottom: 4.0,
                        right: 24.0,
                      ),
                      child: Text(
                        "${documentData['name']}",
                        style: Constants.boldHeading,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 24.0,
                            ),
                            child: Text(
                              "${documentData['price']}" + " Rs/day",
                              style: TextStyle(
                                fontSize: 19.0,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 30),
                            // margin: EdgeInsets.only(left: 155),
                            child: Text(
                              "${documentData['status']}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['desc']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "${documentData['Deposit']}" + " Rs. PreDeposit",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        "Available Sizes",
                        style: Constants.regularDarkText,
                      ),
                    ),
                    ProductSizes(
                      productSizes: productSizes,
                      onSelected: (Size) {
                        _selectedProductSize = Size;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: GestureDetector(
                              onTap: () async {
                                Firestore.instance
                                    .collection('Products')
                                    .document(documentData.id)
                                    .delete();
                                Navigator.of(context).pushNamed('homepage');
                                // await _addToSaved();
                                // Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFDCDCDC),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.delete,
                                    // color: Color.fromARGB(255, 255, 18, 1),
                                    size: 35,
                                  )
                                  // child: Image(
                                  //   image: AssetImage(
                                  //       "assets/images/bookmark.png"),
                                  // height: 22,
                                  // ),
                                  ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  if (x == 'in stock') {
                                    Firestore.instance
                                        .collection('Products')
                                        .document(documentData.id)
                                        .update({'status': 'out of stock'});
                                  } else {
                                    Firestore.instance
                                        .collection('Products')
                                        .document(documentData.id)
                                        .update({'status': 'in stock'});
                                  }
                                });

                                // await _addToCart();
                                // await _addToOrder();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                height: 65.0,
                                margin: EdgeInsets.only(left: 16),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Update Status",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
            hasTitle: false,
            hasbackground: false,
          )
        ],
      ),
    );
  }
}
