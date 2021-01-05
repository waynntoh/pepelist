import 'package:flutter/material.dart';

// COLORS
const kBackgroundColor = Color(0xFFF4F3ED);
const kOrange0 = Color(0xFFFDEBD0);
const kOrange1 = Color(0xFFFAD7A0);
const kOrange2 = Color(0xFFF8C471);
const kOrange3 = Color(0xFFF5B041);
const kOrange4 = Color(0xFFF39C12);
const kOrange5 = Color(0xFFD68910);
const kOrange6 = Color(0xFFCA6F1E);

const kGrey0 = Color(0xFFECECEC);
const kGrey1 = Color(0xFFBBBBBB);
const kGrey2 = Color(0xFF9A9A9A);
const kGrey3 = Color(0xFF9A9A9A);
const kGrey4 = Color(0xFF6B6B6B);
const kGrey5 = Color(0xFF4C4C4C);
const kGrey6 = Color(0xFF2C2C2C);

const kCardColors = [
  Color(0xFFFFF0F0),
  Color(0xFFFFFDF0),
  Color(0xFFF8FFF0),
  Color(0xFFF0FFF8),
  Color(0xFFF0FAFF),
  Color(0xFFF8F0FF),
  Color(0xFFFFF0F2),
];

// SHADOWS
const kButtonShadow = BoxShadow(
  color: kGrey1,
  blurRadius: 1,
  spreadRadius: 1,
  offset: Offset(2, 2.5),
);

const kItemCardShadow = BoxShadow(
  color: kGrey1,
  blurRadius: 2,
  spreadRadius: 1,
  offset: Offset(1, 1.5),
);

const kItemCardTitleShadow = BoxShadow(
  color: kGrey4,
  blurRadius: 1,
  spreadRadius: .1,
  offset: Offset(0, 1),
);

// TEXTSTYLES
const kHeaderTextStyle = TextStyle(
  fontFamily: 'FredokaOne',
  fontSize: 28,
);

const kDefaultTextStyle = TextStyle(
  fontFamily: 'Judson',
  fontSize: 16,
);

// TEXTFIELD DECORATIONS
const kTextFieldDecoration = InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(vertical: 4),
  fillColor: kOrange3,
  focusColor: kOrange3,
  hoverColor: kOrange3,
  hintStyle: kDefaultTextStyle,
  counterStyle: kDefaultTextStyle,
  suffixStyle: kDefaultTextStyle,
  helperStyle: kDefaultTextStyle,
  labelStyle: kDefaultTextStyle,
  prefixStyle: kDefaultTextStyle,
);

// // SPINKITS
// Widget kSpinKitLoader = SpinKitWave(
//   type: SpinKitWaveType.center,
//   color: kOrange2,
//   size: 100,
// );

// Widget kLargeImageLoader = SpinKitSquareCircle(
//   color: kOrange0,
//   size: 100,
// );

// Widget kSmallImageLoader = SpinKitSquareCircle(
//   color: kOrange1,
//   size: 50,
// );
