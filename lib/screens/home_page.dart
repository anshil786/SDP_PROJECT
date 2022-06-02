import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/bottom_tabs.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';
import 'package:sem6_sdp_erent/tabs/home_tab.dart';
import 'package:sem6_sdp_erent/tabs/saved_tab.dart';
import 'package:sem6_sdp_erent/tabs/search_tab.dart';

import '../services/firebase_services.dart';
import '../tabs/new_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  late PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
                controller: _tabsPageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedTab = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  newProductTab(),
                  SavedTab(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'THANK YOU!! PLEASE VISIT AGAIN.',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      FlatButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        // //disabledTextColor: Colors.orange,
                        // // hoverColor: Colors.orange,
                        splashColor: Color(0xFFFF1E00),
                        // //disabledColor: Colors.blue,
                        // // elevation: 5,
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, 'login');
                        },

                        child: Text("Click Here to LOGOUT"),
                      ),
                    ],
                  ),
                ]),
          ),
          Bottomtabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(
                () {
                  _tabsPageController.animateToPage(num,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
