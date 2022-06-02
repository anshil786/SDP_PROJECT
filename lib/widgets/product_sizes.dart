import 'package:flutter/material.dart';

class ProductSizes extends StatefulWidget {
  final List? productSizes;
  final Function(String)? onSelected;
  ProductSizes({this.productSizes, this.onSelected});

  @override
  _ProductSizesState createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes!.length; i++)
            GestureDetector(
              // onTap: () {
              //   widget.onSelected!("${widget.productSizes![i]}");
              //   setState(() {
              //     _selected = i;
              //   });
              // },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Color(0xFF808080),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Text(
                  "${widget.productSizes![i]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
