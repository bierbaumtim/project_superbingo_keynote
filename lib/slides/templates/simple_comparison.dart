import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:simple_animations/simple_animations.dart';

class SimpleComparisonSlide extends StatefulWidget {
  final Widget title;
  final Widget? leftComparableTitle;
  final Widget? leftComparableContent;
  final Widget? rightComparableTitle;
  final Widget? rightComparableContent;
  final CrossAxisAlignment titleAlignment;

  final bool showLeftComparableTitle;
  final bool showLeftComparableContent;
  final bool showRightComparableTitle;
  final bool showRightComparableContent;

  const SimpleComparisonSlide({
    super.key,
    required this.title,
    this.titleAlignment = CrossAxisAlignment.center,
    this.leftComparableTitle,
    this.leftComparableContent,
    this.rightComparableTitle,
    this.rightComparableContent,
    this.showLeftComparableTitle = true,
    this.showRightComparableTitle = true,
    this.showLeftComparableContent = true,
    this.showRightComparableContent = true,
  });

  @override
  State<SimpleComparisonSlide> createState() => _SimpleComparisonSlideState();
}

class _SimpleComparisonSlideState extends State<SimpleComparisonSlide> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: kSlideBackground,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final titleFontsize = calculateTitleFontsize(constraints.maxWidth);
            final subtitleFontsize =
                calculateSubtitleFontsize(constraints.maxWidth);
            final contentFontsize =
                calculateContentFontsize(constraints.maxWidth);

            return Padding(
              padding: const EdgeInsets.all(1.5 * kToolbarHeight),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      if (widget.titleAlignment == CrossAxisAlignment.center ||
                          widget.titleAlignment == CrossAxisAlignment.end)
                        const Spacer(),
                      DefaultTextStyle(
                        style: kBasicTextStyle.copyWith(
                          fontSize: titleFontsize,
                        ),
                        child: widget.title,
                      ),
                      if (widget.titleAlignment == CrossAxisAlignment.center ||
                          widget.titleAlignment == CrossAxisAlignment.start)
                        const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 1.5 * kToolbarHeight),
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
                                  child: PlayAnimationBuilder(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (_, animatedValue, child) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: child,
                                    ),
                                    child: widget.leftComparableTitle,
                                  ),
                                ),
                              if (widget.leftComparableContent != null &&
                                  widget.showLeftComparableContent)
                                Expanded(
                                  child: PlayAnimationBuilder(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (_, animatedValue, child) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: child,
                                    ),
                                    child: DefaultTextStyle(
                                      style: kBasicTextStyle.copyWith(
                                        fontSize: contentFontsize,
                                      ),
                                      child: widget.leftComparableContent!,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: kToolbarHeight),
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
                                  child: PlayAnimationBuilder(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (_, animatedValue, child) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: child,
                                    ),
                                    child: widget.rightComparableTitle,
                                  ),
                                ),
                              if (widget.rightComparableContent != null &&
                                  widget.showRightComparableContent)
                                Expanded(
                                  child: PlayAnimationBuilder(
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 550),
                                    delay: const Duration(milliseconds: 250),
                                    builder: (_, animatedValue, child) =>
                                        Opacity(
                                      opacity: animatedValue,
                                      child: child,
                                    ),
                                    child: DefaultTextStyle(
                                      style: kBasicTextStyle.copyWith(
                                        fontSize: contentFontsize,
                                      ),
                                      child: widget.rightComparableContent!,
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
