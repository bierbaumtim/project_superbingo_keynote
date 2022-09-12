import 'package:flutter/cupertino.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/simple_comparison.dart';

class StatelessVSStafulSlide extends Slide {
  const StatelessVSStafulSlide({required Key key}) : super(key: key);

  @override
  _StatelessVSStafulSlideState createState() => _StatelessVSStafulSlideState();
}

class _StatelessVSStafulSlideState extends SlideState<StatelessVSStafulSlide> {
  late bool showLeftText, showLeftContent, showRightText, showRightContent;

  @override
  void initState() {
    super.initState();
    showLeftText = false;
    showLeftContent = false;
    showRightText = false;
    showRightContent = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleComparisonSlide(
      title: Text('Stateless vs. Stateful'),
      titleAlignment: CrossAxisAlignment.start,
      leftComparableTitle: Text('Text'),
      rightComparableTitle: Text('CupertinoSwitch'),
      leftComparableContent: Align(
        alignment: Alignment(-.25, 0),
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'Hello '),
              TextSpan(
                text: 'beautiful ',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: 'world',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      rightComparableContent: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 48),
            Transform.scale(
              scale: 2,
              child: CupertinoSwitch(
                value: false,
                onChanged: (_) {},
              ),
            ),
            Spacer(),
            Transform.scale(
              scale: 2,
              child: CupertinoSwitch(
                value: true,
                onChanged: (_) {},
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      showLeftComparableTitle: showLeftText,
      showLeftComparableContent: showLeftContent,
      showRightComparableTitle: showRightText,
      showRightComparableContent: showRightContent,
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (!showLeftText) {
        setState(() => showLeftText = true);
        return false;
      }

      if (!showLeftContent) {
        setState(() => showLeftContent = true);
        return false;
      }

      if (!showRightText) {
        setState(() => showRightText = true);
        return false;
      }

      if (!showRightContent) {
        setState(() {
          showRightContent = true;
        });
        return false;
      }

      return true;
    } else if (action == kPreviousAction) {
      if (showRightContent) {
        setState(() {
          showRightContent = false;
        });
        return false;
      }

      if (showRightText) {
        setState(() => showRightText = false);
        return false;
      }

      if (showLeftContent) {
        setState(() {
          showLeftContent = false;
        });
        return false;
      }

      if (showLeftText) {
        setState(() {
          showLeftText = false;
        });
        return false;
      }
    }
    return true;
  }
}
