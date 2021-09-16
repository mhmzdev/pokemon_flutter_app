import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color btnColor;
  final double width;
  final double height;
  final Function onPressed;
  final Widget child;

  const CustomButton(
      {Key key,
      this.width = 250.0,
      this.height = 45.0,
      this.btnColor = Colors.red,
      @required this.onPressed,
      @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(btnColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
