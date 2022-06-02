import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/widgets/custom_btn.dart';
import 'package:sem6_sdp_erent/widgets/custom_input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error occured"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("close"))
            ],
          );
        });
  }

  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerformLoading = true;
    });
    String? _creteAccountFeedBack = await _createAccount();
    // print(_creteAccountFeedBack);
    // Firestore.instance.collection('Users').doc()
    if (_creteAccountFeedBack != null) {
      _alertDialogBuilder(_creteAccountFeedBack);
      setState(() {
        _registerformLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerformLoading = false;
  String _registerEmail = "";
  String _registerPassword = "";
  late FocusNode _passwordFocusNode;
  // late FocusNode _emailFocusNode;
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  "create new account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email...",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmit: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                    isPasswordField: false,
                  ),
                  CustomInput(
                    hintText: "password...",
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    onSubmit: (value) {
                      _submitForm();
                    },
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    isPasswordField: true,
                  ),
                  CustomBtn(
                    text: "create new account",
                    onPressed: () {
                      _submitForm();
                    },
                    // outlineBtn: false,
                    isloading: _registerformLoading,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: CustomBtn(
                  text: "back to login",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                  isloading: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
