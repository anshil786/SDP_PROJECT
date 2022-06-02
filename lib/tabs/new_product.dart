import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../screens/constants.dart';
import '../widgets/custom_actionbar.dart';
import '../widgets/product_sizes.dart';

class newProductTab extends StatefulWidget {
  @override
  State<newProductTab> createState() => _newProductTabState();
}

class _newProductTabState extends State<newProductTab> {
  // const newProductTab({Key? key}) : super(key: key);
  bool _isLoading = false;
  bool inStock = true;
  @override
  Widget build(BuildContext context) {
    String? productName;
    String? description;
    String? price;
    String? deposit;
    String? searchString;

    List<String> productSizes = new List<String>.empty(growable: true);
    List<String> selectedProductSizes = new List<String>.empty(growable: true);
    List<File> selectedImages = new List<File>.empty(growable: true);
    List<String> selectedImagesUrl = new List<String>.empty(growable: true);

    productSizes
        .addAll(['S', 'M', 'L', 'XL', 'XXL', '28', '30', '32', '34', '36']);

    File? selectedImage;
    final bool updateScreen;
    final String imgUrl;
    String? statusss;
    //   final SnackBar _snackBar = SnackBar(
    //   content: Text("Product Added"),
    // );
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // CustomActionBar(
                //   hasbackArrow: false,
                //   title: "ADD PRODUCT",
                // ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Text(
                        "ADD PRODUCT",
                        style: Constants.boldHeading,
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (value) {
                          productName = value;
                        },
                        decoration: InputDecoration(
                            // hintText: " Name",
                            labelText: "Product Name",
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            border: InputBorder.none,
                            fillColor: Colors.black12,
                            filled: true),
                        obscureText: false,
                        maxLength: 30,
                      ),
                      // TextField(
                      //   onChanged: (value) {
                      //     statusss = value;
                      //   },
                      //   decoration: InputDecoration(
                      //       // hintText: " Name",
                      //       labelText: "Enter status",
                      //       labelStyle:
                      //           TextStyle(fontSize: 15, color: Colors.black),
                      //       border: InputBorder.none,
                      //       fillColor: Colors.black12,
                      //       filled: true),
                      //   obscureText: false,
                      //   maxLength: 20,
                      // ),
                      TextField(
                        onChanged: (value) {
                          description = value;
                        },
                        decoration: InputDecoration(
                            //hintText: "",
                            labelText: "Description",
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
                          price = value;
                        },
                        decoration: InputDecoration(
                            // hintText: " Name",
                            labelText: "Price",
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            border: InputBorder.none,
                            fillColor: Colors.black12,
                            filled: true),
                        obscureText: false,
                        maxLength: 30,
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        onChanged: (value) {
                          deposit = value;
                        },
                        decoration: InputDecoration(
                            // hintText: " xxxxxxxxxx",
                            labelText: "Deposit",
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            border: InputBorder.none,
                            fillColor: Colors.black12,
                            filled: true),
                        obscureText: false,
                        maxLength: 20,
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        onChanged: (value) {
                          searchString = value;
                        },
                        decoration: InputDecoration(
                            // hintText: "number of days you want to rent product",
                            labelText: "Search String",
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            border: InputBorder.none,
                            fillColor: Colors.black12,
                            filled: true),
                        obscureText: false,
                        maxLength: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 5.0,
                        ),
                        child: Text(
                          "Choose Size",
                          style: Constants.regularDarkText,
                        ),
                      ),
                      StatefulBuilder(builder: (context, setStateFul) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              // left: 20.0,
                              ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var i = 0; i < productSizes.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      setStateFul(() {
                                        if (selectedProductSizes
                                            .contains(productSizes[i])) {
                                          selectedProductSizes
                                              .remove(productSizes[i]);
                                        } else {
                                          selectedProductSizes
                                              .add(productSizes[i]);
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: 42.0,
                                      height: 42.0,
                                      decoration: BoxDecoration(
                                        color: selectedProductSizes
                                                .contains(productSizes[i])
                                            ? Theme.of(context).accentColor
                                            : Color(0xFF808080),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Text(
                                        "${productSizes[i]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: selectedProductSizes
                                                  .contains(productSizes[i])
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 5.0,
                        ),
                        child: Text(
                          "Choose Images",
                          style: Constants.regularDarkText,
                        ),
                      ),
                      StatefulBuilder(builder: (context, setStateFul) {
                        void _pickImage({required bool iscamera}) async {
                          final _pickedImage = await ImagePicker.pickImage(
                            source: iscamera
                                ? ImageSource.camera
                                : ImageSource.gallery,
                            imageQuality: 50,
                          );
                          setStateFul(() {
                            selectedImage = _pickedImage;
                            print(selectedImage);
                          });
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                          child: Container(
                                            height: 200,
                                            width: 200,
                                            color: Colors.white,
                                            child: selectedImage == null
                                                ? Center(
                                                    child: Text(
                                                        "No Image Selected"),
                                                  )
                                                : Image.file(
                                                    selectedImage!,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),

                                        // widget._imageFn(selectedImage!);

                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FlatButton.icon(
                                                  onPressed: () => _pickImage(
                                                      iscamera: true),
                                                  icon: Icon(Icons.camera),
                                                  label: Text('Use Camera')),
                                              FlatButton.icon(
                                                  onPressed: () => _pickImage(
                                                      iscamera: false),
                                                  icon: Icon(Icons.image),
                                                  label: Text('Use Gallery')),
                                              FlatButton.icon(
                                                  onPressed: () {
                                                    setStateFul(() {
                                                      if (selectedImage != null)
                                                        selectedImages.add(
                                                            selectedImage!);
                                                      selectedImage = null;
                                                    });
                                                    // selectedImage = null;
                                                    print(selectedImages);
                                                  },
                                                  icon:
                                                      Icon(Icons.add_to_photos),
                                                  label: Text('Add To List')),
                                              FlatButton.icon(
                                                  onPressed: () {
                                                    setStateFul(() {
                                                      selectedImage = null;
                                                    });
                                                  },
                                                  icon: Icon(Icons.clear),
                                                  label: Text('Clear Image'))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 5.0,
                              ),
                              child: Text(
                                "Selected Images",
                                style: Constants.regularDarkText,
                              ),
                            ),
                            if (selectedImages.isEmpty)
                              Center(
                                child: Container(
                                  // width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "No Images Selected Yet",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            if (selectedImages.isNotEmpty)
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) {
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        child:
                                            Image.file(selectedImages[index]),
                                      );
                                    },
                                    itemCount: selectedImages.length,
                                  )),
                            StatefulBuilder(builder: ((context, setStateFul) {
                              return Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'in Stock',
                                        style: Constants.regularDarkText,
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(10),
                                        child: FlutterSwitch(
                                            showOnOff: true,
                                            activeText: 'yes',
                                            inactiveText: 'no',
                                            activeColor: Colors.black,
                                            value: inStock,
                                            onToggle: (onToggle) {
                                              setStateFul(() {
                                                inStock = onToggle;
                                                if (onToggle) {
                                                  statusss = 'in stock';
                                                } else {
                                                  statusss = 'out of stock';
                                                }
                                              });
                                            }),
                                      ),
                                    ]),
                              );
                            }))
                          ],
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RaisedButton(
                          color: Colors.black,
                          textColor: Colors.white,
                          //disabledTextColor: Colors.orange,
                          // hoverColor: Colors.orange,
                          splashColor: Color(0xFFFF1E00),
                          //disabledColor: Colors.blue,
                          elevation: 5,

                          onPressed: () async {
                            if (productName!.isEmpty ||
                                price!.isEmpty ||
                                description!.isEmpty ||
                                searchString!.isEmpty ||
                                deposit!.isEmpty ||
                                selectedImages.isEmpty ||
                                selectedProductSizes.isEmpty) {
                              Scaffold.of(context).showSnackBar(new SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Provide data Properly!!')));
                              return;
                            }

                            setState(() {
                              _isLoading = true;
                            });
                            for (int i = 0; i < selectedImages.length; i++) {
                              var ref = FirebaseStorage.instance
                                  .ref()
                                  .child(DateTime.now().toString() + '.jpg');

                              await ref.putFile(selectedImages[i]).onComplete;

                              String url = await ref.getDownloadURL();
                              selectedImagesUrl.add(url);
                            }
                            var id = DateTime.now().toString();
                            await Firestore.instance
                                .collection('Products')
                                .document(id)
                                .setData({
                              'name': productName,
                              'price': price,
                              'search_string': searchString,
                              'Deposit': deposit,
                              'desc': description,
                              'status': statusss,
                              'images':
                                  FieldValue.arrayUnion(selectedImagesUrl),
                              'size':
                                  FieldValue.arrayUnion(selectedProductSizes)
                            });
                            setState(() {
                              _isLoading = false;
                            });
                            Scaffold.of(context).showSnackBar(new SnackBar(
                                backgroundColor: Colors.green[400],
                                content: Text('Product Added')));
                            // await _addToCart().add({
                            //   'firstname': firstName,
                            //   'lastname': lastName,
                            //   'mobilenumber': mobileNumber,
                            //   'Days': numberofDays,
                            //   'email': email,
                            //   'deliveryaddress': deliveryAddress,
                            //   'pincode': pinCode,
                            // });
                            // Navigator.pushNamed(context, 'Success');
                            // _onPressed();
                            Navigator.pushNamed(context, 'homepage');
                          },

                          child: Text("Add Product"),

                          // minWidth: 200,
                          // height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 50,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
