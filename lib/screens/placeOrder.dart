//import 'dart:html';

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';
import '../widgets/custom_actionbar.dart';
import 'package:sem6_sdp_erent/screens/product_page.dart';

class PlaceOrder extends StatefulWidget {
  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  FirebaseServices _firebaseServices = FirebaseServices();
  void _onPressed() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    User user = FirebaseAuth.instance.currentUser;

    Firestore.instance.collection("Users").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Firestore.instance
            .collection("Users")
            .document(user.uid)
            .collection("Cart")
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) {
            Firestore.instance
                .collection("Order")
                .document()
                .setData(result.data());
          });
        });
      });
    });
  }

  // User user = FirebaseAuth.instance.currentUser;
  // CollectionReference Details =     Firestore.instance.collection('Users').collection('subCollectionPath').setData({});
  CollectionReference _addToCart() {
    return _firebaseServices.userRef
        .doc(_firebaseServices.getUserId())
        .collection("Details");
  }

  late String firstName;

  late String lastName;

  late String mobileNumber;

  late String numberofDays;

  late String email;

  late String deliveryAddress;

  late String pinCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomActionBar(
              hasbackArrow: true,
              title: "ORDER DETAILS",
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration: InputDecoration(
                        // hintText: " Name",
                        labelText: "First Name",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 30,
                  ),
                  TextField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: InputDecoration(
                        // hintText: " Name",
                        labelText: "Last Name",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 30,
                  ),
                  TextField(
                    onChanged: (value) {
                      mobileNumber = value;
                    },
                    decoration: InputDecoration(
                        hintText: " xxxxxxxxxx",
                        labelText: "Mobile Number",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    onChanged: (value) {
                      numberofDays = value;
                    },
                    decoration: InputDecoration(
                        hintText: "number of days you want to rent product",
                        labelText: "Number Of Days",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        //hintText: "",
                        labelText: "Email",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 20,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    onChanged: (value) {
                      deliveryAddress = value;
                    },
                    decoration: InputDecoration(
                        //hintText: "",
                        labelText: "Delivery Address",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 300,
                    maxLines: 3,
                    //keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    onChanged: (value) {
                      pinCode = value;
                    },
                    decoration: InputDecoration(
                        hintText: " xxxxxx",
                        labelText: "Pin Code",
                        labelStyle:
                            TextStyle(fontSize: 15, color: Colors.black),
                        border: InputBorder.none,
                        fillColor: Colors.black12,
                        filled: true),
                    obscureText: false,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                  ),
                  RaisedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    //disabledTextColor: Colors.orange,
                    // hoverColor: Colors.orange,
                    splashColor: Color(0xFFFF1E00),
                    //disabledColor: Colors.blue,
                    elevation: 5,

                    onPressed: () async {
                      await _addToCart().add({
                        'firstname': firstName,
                        'lastname': lastName,
                        'mobilenumber': mobileNumber,
                        'Days': numberofDays,
                        'email': email,
                        'deliveryaddress': deliveryAddress,
                        'pincode': pinCode,
                      });
                      Navigator.pushNamed(context, 'Success');
                      _onPressed();
                    },

                    child: Text("Place Order"),

                    // minWidth: 200,
                    // height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text("details")),
//     );
//   }
  }
}
