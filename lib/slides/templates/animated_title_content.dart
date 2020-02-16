import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

class AnimatedTitleContentSlide extends Slide {
  final Widget title;
  final List<Text> content;
  final CrossAxisAlignment titleAlignment;
  final MainAxisAlignment contentMainAxisAligment;
  final CrossAxisAlignment contentCrossAxisAlignment;
  final Map<int, int> partsLayer;

  const AnimatedTitleContentSlide({
    Key key,
    this.title,
    this.content,
    this.contentMainAxisAligment = MainAxisAlignment.center,
    this.contentCrossAxisAlignment = CrossAxisAlignment.stretch,
    this.titleAlignment = CrossAxisAlignment.center,
    this.partsLayer = const <int, int>{},
  }) : super(key: key);

  @override
  _TitleContentSlideState createState() => _TitleContentSlideState();
}

class _TitleContentSlideState extends SlideState<AnimatedTitleContentSlide>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  int lastVisiblePart, stackIndex;
  bool reverseContent;
  Alignment titleEndAligment;

  // Animations
  AnimationController titlePositionController;
  Tween<Alignment> titleAlignTween;
  Animation<Alignment> currentTitleAligment;

  @override
  void initState() {
    super.initState();
    lastVisiblePart = -1;
    stackIndex = 0;
    reverseContent = false;
    titleEndAligment = calculateTitleEndAlignment(widget.titleAlignment);
    titlePositionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    titlePositionController.addListener(() {
      setState(() {});
    });
    titleAlignTween = Tween<Alignment>(
      begin: Alignment(0, 0),
      end: titleEndAligment,
    );
    currentTitleAligment = titleAlignTween.animate(titlePositionController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  void dispose() {
    titlePositionController.dispose();
    super.dispose();
  }

  Alignment calculateTitleEndAlignment(CrossAxisAlignment crossAxisAlignment) {
    switch (crossAxisAlignment) {
      case CrossAxisAlignment.center:
      case CrossAxisAlignment.stretch:
        return Alignment.topCenter;
      case CrossAxisAlignment.end:
        return Alignment.topRight;
      case CrossAxisAlignment.start:
      default:
        return Alignment.topLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleTap(kNextAction),
      child: KeyboardHandler(
        onKeyboardTap: handleTap,
        child: Material(
          color: kSlideBackground,
          child: Padding(
            padding: const EdgeInsets.all(kToolbarHeight),
            child: IndexedStack(
              index: stackIndex,
              children: <Widget>[
                Align(
                  alignment: currentTitleAligment.value,
                  child: DefaultTextStyle(
                    style: kTitleContentTitleTextStyle,
                    child: widget.title,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (widget.titleAlignment ==
                                CrossAxisAlignment.center ||
                            widget.titleAlignment == CrossAxisAlignment.end)
                          Spacer(),
                        DefaultTextStyle(
                          style: kTitleContentTitleTextStyle,
                          child: widget.title,
                        ),
                        if (widget.titleAlignment ==
                                CrossAxisAlignment.center ||
                            widget.titleAlignment == CrossAxisAlignment.start)
                          Spacer(),
                      ],
                    ),
                    SizedBox(height: 32),
                    Expanded(
                      child: RevealingText(
                        parts: widget.content,
                        lastVisiblePart: lastVisiblePart,
                        crossAxisAlignment: widget.contentCrossAxisAlignment,
                        mainAxisAligment: widget.contentMainAxisAligment,
                        reverse: reverseContent,
                        partsLayer: widget.partsLayer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (titlePositionController.isCompleted) {
        setState(() {
          stackIndex = 1;
        });
        if (lastVisiblePart < widget.content.length - 1) {
          setState(() {
            reverseContent = false;
            lastVisiblePart += 1;
          });
          return false;
        } else {
          return true;
        }
      } else {
        titlePositionController.forward();
        return false;
      }
    } else if (action == kPreviousAction) {
      if (lastVisiblePart >= 0) {
        setState(() {
          reverseContent = true;
          lastVisiblePart -= 1;
        });
        return false;
      } else if (titlePositionController.isCompleted) {
        setState(() {
          stackIndex = 0;
        });
        titlePositionController.reverse();
        return false;
      }
      return true;
    }
    return false;
  }
}
