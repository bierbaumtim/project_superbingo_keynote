import 'package:flutter/material.dart';

// Basic Styles
const kBasicTextStyle = TextStyle(
  fontFamily: 'Consolas',
  fontSize: 35,
  color: Colors.black,
  height: 1.1288,
);

const kBasicTextTheme = TextTheme(
  bodyText2: kBasicTextStyle,
  bodyText1: kBasicTextStyle,
  headline1: TextStyle(
    fontFamily: 'Consolas',
    fontSize: 64,
    color: Colors.black,
    height: 1.1288,
  ),
);

// Title Slide Styles
final kTitleContentTitleTextStyle = kBasicTextStyle.copyWith(
  fontSize: 72,

);

// Topic Slide Styles
final kTopicTitleTextStyle = kBasicTextStyle.copyWith(
  fontSize: 120,
);

final kTopicSubtitleTextStyle = kBasicTextStyle.copyWith(
  fontSize: 50,
);

// Comparison Styles
final kComparisonComparableTitleTextStyle = kBasicTextStyle.copyWith(
  fontSize: 36,
  fontWeight: FontWeight.bold,
);
