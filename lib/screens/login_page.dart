import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sem6_sdp_erent/screens/register_page.dart';
import 'package:sem6_sdp_erent/widgets/custom_btn.dart';
import 'package:sem6_sdp_erent/widgets/custom_input.dart';
//import 'package:sem6_sdp_erent/widgets/cstm_btn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
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

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
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
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _loginformLoading = true;
    });
    String? _signInFeedBack = await _loginAccount();
    if (_signInFeedBack != null) {
      _alertDialogBuilder(_signInFeedBack);
      setState(() {
        _loginformLoading = false;
      });
    }
  }

  bool _loginformLoading = false;
  String _loginEmail = "";
  String _loginPassword = "";
  late FocusNode _passwordFocusNode;
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
      body: Container(
        padding: EdgeInsets.only(top: 20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 54),
              child: Text(
                "Welcome to ERENT \n Login to your account!",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 115,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextFormField(
                      validator: (value) {
                        if (value != "admin123@gmail.com") {
                          return "Please Enter ADMIN Email id";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _loginEmail = value;
                      },
                      onSaved: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email...",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                      ),
                      style: Constants.regularDarkText,
                    ),
                  ),
                ),
                // CustomInput(
                //   hintText: "Email...",

                //   onChanged: (value) {
                //     _loginEmail = value;
                //   },
                //   onSubmit: (value) {
                //     _passwordFocusNode.requestFocus();
                //   },
                //   textInputAction: TextInputAction.next,
                //   isPasswordField: false,
                // ),
                CustomInput(
                  hintText: "password...",
                  onChanged: (value) {
                    _loginPassword = value;
                  },
                  onSubmit: (value) {
                    _submitForm();
                  },
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  isPasswordField: true,
                ),
                CustomBtn(
                  text: "login",
                  onPressed: () {
                    _submitForm();
                  },
                  // outlineBtn: false,
                  isloading: _loginformLoading,
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 16),
            //   child: CustomBtn(
            //     text: "create new account ",
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => RegisterPage()));
            //     },
            //     outlineBtn: true,
            //     isloading: false,
            //   ),
            // ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
