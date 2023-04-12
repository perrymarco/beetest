import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextControll extends StatelessWidget {
  const CustomTextControll({
    required String hintText,
    bool isPassword = false,
    required TextEditingController ctrl,
    EdgeInsets padding = const EdgeInsets.only(left: 40),
    Key? key,
  })  : _hintText = hintText,
        _isPassword = isPassword,
        _ctrl = ctrl,
        _padding = padding,
        super(key: key);

  final String _hintText;
  final bool _isPassword;
  final TextEditingController _ctrl;
  final EdgeInsets _padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: ShapeDecoration(
        color: AppColor.placeholderBg,
        shape: StadiumBorder(),
      ),
      child: TextField(
        autocorrect: false,
        controller: _ctrl,
        obscureText: _isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: _hintText,
          hintStyle: TextStyle(
            fontSize: 20,
            color: AppColor.placeholder,
          ),
          contentPadding: _padding,
        ),
      ),
    );
  }
}
