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
  fontSize: 140,
);

final kTopicSubtitleTextStyle = kBasicTextStyle.copyWith(
  fontSize: 50,
);

// Comparison Styles
final kComparisonComparableTitleTextStyle = kBasicTextStyle.copyWith(
  fontSize: 36,
  fontWeight: FontWeight.bold,
);

/// Berechnet die Kontrastfarbe zur `color`
Color getContrastColor(Color color) {
  // Calculate the perceptive luminance - human eye favors green color...
  final luma =
      ((0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue)) /
          255;

  // Return black for bright colors, white for dark colors
  return luma > 0.5 ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
}