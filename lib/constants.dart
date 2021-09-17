import 'package:flutter/material.dart';

// colors
const kPrimaryColor = Color(0xffe84f4b);

// text styles
const kHeadingStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

const kBtnTextStyle = TextStyle(
  fontSize: 16.0,
  letterSpacing: 1.2,
);

const kHintStyle = TextStyle(
  fontSize: 13.0,
  letterSpacing: 1.2,
);

// border
var kOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
);

var kErrorOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    color: kPrimaryColor,
  ),
);

// loader
const kBtnLoader = SizedBox(
  height: 22.0,
  width: 22.0,
  child: CircularProgressIndicator(
    strokeWidth: 2.0,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  ),
);
