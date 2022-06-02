import 'package:flutter/material.dart';

class Bottomtabs extends StatefulWidget {
  final int? selectedTab;
  final Function(int)? tabPressed;
  Bottomtabs({this.selectedTab, this.tabPressed});
  @override
  State<Bottomtabs> createState() => _BottomtabsState();
}

class _BottomtabsState extends State<Bottomtabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabsBtn(
              imagePath: "assets/images/homee.png",
              selected: _selectedTab == 0 ? true : false,
              onPressed: () {
                widget.tabPressed!(0);
              },
            ),
            BottomTabsBtn(
              imagePath: "assets/images/search.png",
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.tabPressed!(1);
              },
            ),
            BottomTabsBtn(
              imagePath: "assets/images/addmore.png",
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                widget.tabPressed!(2);
              },
            ),
            // BottomTabsBtn(
            //   imagePath: "assets/images/bookmark.png",
            //   selected: _selectedTab == 3 ? true : false,
            //   onPressed: () {
            //     widget.tabPressed!(3);
            //   },
            // ),
            BottomTabsBtn(
              imagePath: "assets/images/summary-2.png",
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                widget.tabPressed!(3);
              },
            ),
            BottomTabsBtn(
              imagePath: "assets/images/logout.png",
              selected: _selectedTab == 4 ? true : false,
              onPressed: () {
                widget.tabPressed!(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String? imagePath;
  final bool? selected;
  final VoidCallback? onPressed;
  BottomTabsBtn({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 28.0,
            horizontal: 24.0,
          ),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
            color:
                _selected ? Theme.of(context).accentColor : Colors.transparent,
            width: 2.0,
          ))),
          child: Image(
            image: AssetImage(
              imagePath ?? "assets/images/homee.png",
            ),
            width: 24.0,
            height: 22.0,
            color: _selected ? Theme.of(context).accentColor : Colors.black,
          )),
    );
  }
}
