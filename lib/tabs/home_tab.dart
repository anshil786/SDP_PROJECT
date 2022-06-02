// import 'dart:html';
// import 'package:firebase/firebase.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/screens/product_page.dart';
import 'package:sem6_sdp_erent/widgets/custom_actionbar.dart';
import 'package:sem6_sdp_erent/widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Center(
          //   child: Text("Home Tab"),
          // ),
          FutureBuilder<QuerySnapshot>(
            future: _productRef.get(),
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
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "${document.data()['price']}",
                      productId: document.id,
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
            title: "Home",
            hasbackArrow: false,
          ),
        ],
      ),
    );
  }
}
