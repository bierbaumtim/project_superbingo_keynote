import 'package:flutter/material.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:simple_animations/simple_animations.dart';

class SimpleComparisonSlide extends StatefulWidget {
  final Widget title;
  final Widget leftComparableTitle;
  final Widget leftComparableContent;
  final Widget rightComparableTitle;
  final Widget rightComparableContent;
  final CrossAxisAlignment titleAlignment;

  final bool showLeftComparableTitle;
  final bool showLeftComparableContent;
  final bool showRightComparableTitle;
  final bool showRightComparableContent;

  const SimpleComparisonSlide({
    Key key,
    @required this.title,
    this.titleAlignment = CrossAxisAlignment.center,
    this.leftComparableTitle,
    this.leftComparableContent,
    this.rightComparableTitle,
    this.rightComparableContent,
    this.showLeftComparableTitle = true,
    this.showRightComparableTitle = true,
    this.showLeftComparableContent = true,
    this.showRightComparableContent = true,
  }) : super(key: key);

  @override
  _SimpleComparisonSlideState createState() => _SimpleComparisonSlideState();
}

class _SimpleComparisonSlideState extends State<SimpleComparisonSlide> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: kSlideBackground,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final titleFontsize = (constraints.maxWidth / 14) * 0.6;
            final subtitleFontsize = (constraints.maxWidth / 14) / 2.75;
            final contentFontsize = titleFontsize * 0.65;

            return Padding(
              padding: const EdgeInsets.all(1.5 * kToolbarHeight),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      if (widget.titleAlignment == CrossAxisAlignment.center ||
                          widget.titleAlignment == CrossAxisAlignment.end)
                        Spacer(),
                      DefaultTextStyle(
                        style: kBasicTextStyle.copyWith(
                          fontSize: titleFontsize,
                        ),
                        child: widget.title,
                      ),
                      if (widget.titleAlignment == CrossAxisAlignment.center ||
                          widget.titleAlignment == CrossAxisAlignment.start)
                        Spacer(),
                    ],
                  ),
                  SizedBox(height: 1.5 * kToolbarHeight),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (widget.leftComparableTitle != null &&
                                  widget.showLeftComparableTitle)
                                DefaultTextStyle(
                                  style: kBasicTextStyle.copyWith(
                                    fontSize: subtitleFontsize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  child: ControlledAnimation(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (buildContext, animatedValue) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: widget.leftComparableTitle,
                                    ),
                                  ),
                                ),
                              if (widget.leftComparableContent != null &&
                                  widget.showLeftComparableContent)
                                Expanded(
                                  child: ControlledAnimation(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (buildContext, animatedValue) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: DefaultTextStyle(
                                        style: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        child: widget.leftComparableContent,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(width: kToolbarHeight),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (widget.rightComparableTitle != null &&
                                  widget.showRightComparableTitle)
                                DefaultTextStyle(
                                  style: kBasicTextStyle.copyWith(
                                    fontSize: subtitleFontsize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  child: ControlledAnimation(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (buildContext, animatedValue) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: widget.rightComparableTitle,
                                    ),
                                  ),
                                ),
                              if (widget.rightComparableContent != null &&
                                  widget.showRightComparableContent)
                                Expanded(
                                  child: ControlledAnimation(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (buildContext, animatedValue) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: DefaultTextStyle(
                                        style: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        child: widget.rightComparableContent,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
