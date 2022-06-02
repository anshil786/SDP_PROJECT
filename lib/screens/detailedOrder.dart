import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import '../services/firebase_services.dart';

import '../widgets/custom_actionbar.dart';

class detailedOrder extends StatefulWidget {
  String userId;
  String orderId;
  final String firstName;

  final String lastName;

  late String mobileNumber;

  late String numberofDays;

  late String email;

  late String deliveryAddress;

  late String pinCode;
  late String date;
  detailedOrder(
      {required this.firstName,
      required this.lastName,
      required this.deliveryAddress,
      required this.email,
      required this.mobileNumber,
      required this.numberofDays,
      required this.pinCode,
      required this.date,
      required this.userId,
      required this.orderId});

  @override
  State<detailedOrder> createState() => _detailedOrderState();
}

class _detailedOrderState extends State<detailedOrder> {
  @override
  Widget build(BuildContext context) {
    // print(widget.orderId);
    return Scaffold(
      // body: Center(child: Text(widget.numberofDays)),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("Users")
                .doc(widget.userId)
                .collection("Details")
                .doc(widget.orderId)
                .collection('personalorder')
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
                print(widget.userId);
                print(widget.orderId);
                print(snapshot.data!.docs);
                return Container(
                  // height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // height: snapshot.data!.docs.length * 200,
                        height: 450,
                        child: ListView(
                          padding: EdgeInsets.only(
                            top: 108.0,
                            // bottom: 24.0,
                          ),
                          children: snapshot.data!.docs.map((document) {
                            return GestureDetector(
                              onTap: () {},
                              child: FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("Products")
                                    .doc(document.id)
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot>
                                        productSnap) {
                                  //List _productMap =  [];
                                  if (productSnap.hasError) {
                                    return Container(
                                      child: Center(
                                          child: Text("${productSnap.error}")),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 115,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  "${_productMap['images'][0]}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 16),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Text(
                                                        "${_productMap['name']}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 4),
                                                          child: Text(
                                                            "${_productMap['price']}Rs/day",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Size - ${document.data()['size']}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    // Text(
                                                    //   "date - ${document.data()['date']}",
                                                    //   style: TextStyle(
                                                    //       fontSize: 16,
                                                    //       color: Colors.black,
                                                    //       fontWeight:
                                                    //           FontWeight.w600),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]);
                                  }
                                  return Container(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.only(left: 10, bottom: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 20,
                                // ),
                                Center(
                                  child: Text(
                                    'Order Details',
                                    style: Constants.boldHeading,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Row(
                                  children: [
                                    Text(
                                      'First Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.firstName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Last Name: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.lastName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Date: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.date,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Email: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.email,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Mobile No.: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.mobileNumber,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Delivery Address: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  widget.deliveryAddress,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Pincode ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.pinCode,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Number of Days: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      widget.numberofDays,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
            title: "Orders",
          ),
        ],
      ),
    );
  }
}
