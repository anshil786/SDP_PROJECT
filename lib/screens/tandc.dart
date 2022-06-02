import 'package:flutter/material.dart';

import '../widgets/custom_actionbar.dart';
import 'constants.dart';

class TandC extends StatefulWidget {
  @override
  State<TandC> createState() => _TandCState();
}

class _TandCState extends State<TandC> {
  bool value = false;
  final SnackBar _snack =
      SnackBar(content: Text("kindly accept terms and conditions!"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomActionBar(
              hasbackArrow: true,
              title: "TERMS AND CONDITIONS",
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 10),
            // ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(
                      "• User is instructed to pay the respective deposit for particular product before taking the charge of product.\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "• User should return product on time or else 20% of product price per day will be deducted from the deposit submitted.\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "• Product should be returned as it is with its original packaging and it should not be damaged. If the product is found vandalized then user has to bear the appropriate charges.\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: value,
                            onChanged: (value) {
                              setState(() {
                                this.value = value!;
                              });
                            }),
                        Text("I accept all Terms and Conditions."),
                      ],
                    ),
                    RaisedButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      //disabledTextColor: Colors.orange,
                      // hoverColor: Colors.orange,
                      splashColor: Color(0xFFFF1E00),
                      //disabledColor: Colors.blue,
                      elevation: 5,
                      onPressed: () => value
                          ? Navigator.pushNamed(context, 'PlaceOrder')
                          : ScaffoldMessenger.of(context).showSnackBar(_snack),
                      child: Text("View Order Summary"),
                      // minWidth: 200,
                      // height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
