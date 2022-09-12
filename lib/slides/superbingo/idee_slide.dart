import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/simple_comparison.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

class IdeeSlide extends Slide {
  const IdeeSlide({required Key key}) : super(key: key);

  @override
  SlideState<IdeeSlide> createState() => _IdeeSlideState();
}

class _IdeeSlideState extends SlideState<IdeeSlide> {
  late bool showSpielText,
      showSpielParts,
      showProjektText,
      showProjektParts,
      reverseSpielParts,
      reverseProjektParts;

  late int lastVisibleSpielPart, lastVisibleProjektPart;

  @override
  void initState() {
    super.initState();
    showSpielText = false;
    showSpielParts = false;
    showProjektText = false;
    showProjektParts = false;
    lastVisibleSpielPart = 0;
    lastVisibleProjektPart = 0;
    reverseSpielParts = false;
    reverseProjektParts = false;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardHandler(
      onKeyboardTap: handleTap,
      child: SimpleComparisonSlide(
        title: const Text('Idee'),
        titleAlignment: CrossAxisAlignment.start,
        leftComparableTitle: const Text('Spiel'),
        rightComparableTitle: const Text('Projekt'),
        leftComparableContent: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
            child: RevealingText(
              parts: const <Text>[
                Text('Kartenspiel mit MauMau Karten'),
                Text('MauMau und Uno Regeln'),
              ],
              lastVisiblePart: lastVisibleSpielPart,
              mainAxisAligment: MainAxisAlignment.start,
              reverse: reverseSpielParts,
            ),
          ),
        ),
        rightComparableContent: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, kToolbarHeight, 0, 0),
            child: RevealingText(
              parts: const <Text>[
                Text(
                  'Als Spaß gemeinte Frage: \n“Kannst du das Spiel nicht als App bauen ?“',
                ),
              ],
              lastVisiblePart: lastVisibleProjektPart,
              mainAxisAligment: MainAxisAlignment.start,
              reverse: reverseProjektParts,
            ),
          ),
        ),
        showLeftComparableTitle: showSpielText,
        showLeftComparableContent: showSpielParts,
        showRightComparableTitle: showProjektText,
        showRightComparableContent: showProjektParts,
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (!showSpielText) {
        setState(() => showSpielText = true);
        return false;
      }

      if (!showSpielParts) {
        setState(() => showSpielParts = true);
        return false;
      }

      if (showSpielParts && lastVisibleSpielPart < 1) {
        setState(() {
          reverseSpielParts = false;
          lastVisibleSpielPart += 1;
        });
        return false;
      }

      if (!showProjektText) {
        setState(() => showProjektText = true);
        return false;
      }

      if (!showProjektParts) {
        setState(() => showProjektParts = true);
        return false;
      }

      return true;
    } else if (action == kPreviousAction) {
      if (showProjektParts) {
        setState(() {
          showProjektParts = false;
          lastVisibleProjektPart = 0;
        });
        return false;
      }

      if (showProjektText) {
        setState(() => showProjektText = false);
        return false;
      }

      if (showSpielParts && lastVisibleSpielPart > 0) {
        setState(() {
          reverseSpielParts = true;
          lastVisibleSpielPart -= 1;
        });
        return false;
      } else if (showSpielParts) {
        setState(() {
          showSpielParts = false;
        });
        return false;
      }

      if (showSpielText) {
        setState(() {
          showSpielText = false;
        });
        return false;
      }
    }
    return true;
  }
}
