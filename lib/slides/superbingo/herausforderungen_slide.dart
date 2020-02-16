import 'package:flutter/material.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/simple_comparison.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

class HerausforderungenSlide extends Slide {
  @override
  _HerausforderungenSlideState createState() => _HerausforderungenSlideState();
}

class _HerausforderungenSlideState extends SlideState<HerausforderungenSlide> {
  bool showLeftText,
      showLeftParts,
      showRightText,
      showRightParts,
      reverseLeftParts,
      reverseRightParts;

  int lastVisibleLeftPart, lastVisibleRightPart;

  @override
  void initState() {
    super.initState();
    showLeftText = false;
    showLeftParts = false;
    showRightText = false;
    showRightParts = false;
    lastVisibleLeftPart = 0;
    lastVisibleRightPart = 0;
    reverseLeftParts = false;
    reverseRightParts = false;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardHandler(
      key: UniqueKey(),
      onKeyboardTap: handleTap,
      child: SimpleComparisonSlide(
        title: Text('Herausforderungen'),
        titleAlignment: CrossAxisAlignment.start,
        leftComparableTitle: Text('UX/UI'),
        rightComparableTitle: Text('Data - Business Logic'),
        leftComparableContent: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
            child: RevealingText(
              parts: <Text>[
                Text('Spielkarte'),
                Text('Kartenhand'),
                Text('Kartenstapel'),
                Text('Mitspieler'),
              ],
              lastVisiblePart: lastVisibleLeftPart,
              mainAxisAligment: MainAxisAlignment.start,
              reverse: reverseLeftParts,
            ),
          ),
        ),
        rightComparableContent: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
            child: RevealingText(
              parts: <Text>[
                Text('Was passiert Serverseitig?'),
                Text('Was passiert Clientseitig?'),
                Text('Wie verhindere ich inkonsistente Daten?'),
              ],
              lastVisiblePart: lastVisibleRightPart,
              mainAxisAligment: MainAxisAlignment.start,
              reverse: reverseRightParts,
            ),
          ),
        ),
        showLeftComparableTitle: showLeftText,
        showLeftComparableContent: showLeftParts,
        showRightComparableTitle: showRightText,
        showRightComparableContent: showRightText,
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (!showLeftText) {
        setState(() => showLeftText = true);
        return false;
      }

      if (!showLeftParts) {
        setState(() => showLeftParts = true);
        return false;
      }

      if (showLeftParts && lastVisibleLeftPart < 4) {
        setState(() {
          reverseLeftParts = false;
          lastVisibleLeftPart += 1;
        });
        return false;
      }

      if (!showRightText) {
        setState(() => showRightText = true);
        return false;
      }

      if (!showRightText) {
        setState(() => showRightText = true);
        return false;
      }

      if (showRightText && lastVisibleRightPart > 3) {
        setState(() {
          reverseRightParts = false;
          lastVisibleRightPart += 1;
        });
        return false;
      }
      return true;
    } else if (action == kPreviousAction) {
      if (showRightText) {
        setState(() {
          showRightText = false;
          lastVisibleRightPart = 0;
        });
        return false;
      }

      if (showRightText && lastVisibleRightPart > 0) {
        setState(() {
          reverseRightParts = true;
          lastVisibleRightPart -= 1;
        });
        return false;
      } else if (showRightText) {
        setState(() => showRightText = false);
        return false;
      }

      if (showLeftParts && lastVisibleLeftPart > 0) {
        setState(() {
          reverseRightParts = true;
          lastVisibleLeftPart -= 1;
        });
        return false;
      } else if (showLeftParts) {
        setState(() {
          showLeftParts = false;
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
