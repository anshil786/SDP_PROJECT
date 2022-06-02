import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/services/firebase_services.dart';
import 'package:sem6_sdp_erent/widgets/custom_input.dart';

import '../widgets/product_card.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "\"Search Result\"",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productRef
                  .orderBy("search_string")
                  .startAt([_searchString]).endAt(
                      ["$_searchString\uf8ff"]).get(),
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
                      top: 120.0,
                      bottom: 24.0,
                    ),
                    children: snapshot.data!.docs.isEmpty
                        ? [
                            SizedBox(height: 40),
                            Center(
                              child: Text("No result found!!"),
                            )
                          ]
                        : snapshot.data!.docs.map((document) {
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
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: CustomInput(
              hintText: "search...",
              onSubmit: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
