import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }
  // String getProductId(){
  //   return
  // }

  final CollectionReference productRef =
      FirebaseFirestore.instance.collection("Products");

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");
  String getProductId() {
    return productRef.id;
  }
}
