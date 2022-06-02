import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sem6_sdp_erent/screens/constants.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? isPasswordField;

  CustomInput(
      {this.hintText,
      this.onChanged,
      this.onSubmit,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField});

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12)),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmit,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
