//import 'dart:html';

import 'package:flutter/material.dart';

import '../screens/product_page.dart';

class ProductCard extends StatelessWidget {
  final String? productId;
  final Function()? onPressed;
  final String? imageUrl;
  final String? title;
  final String? price;
  ProductCard(
      {this.productId, this.onPressed, this.imageUrl, this.title, this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(
                productId: productId,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 550.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        // child: Text("Name: ${document.data()['name']}"),

        child: Stack(
          children: [
            Container(
              height: 600.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageUrl",
                  fit: BoxFit.cover,
                  width: 500,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              //top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black54,
                  Colors.black38,
                  Color.fromARGB(0, 0, 0, 0)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title!,
                        // style: Constants.regularHeading,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      Text(
                        price! + "Rs/day",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
