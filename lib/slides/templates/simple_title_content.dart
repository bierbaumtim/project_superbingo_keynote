import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

class TitleContentSlide extends Slide {
  final Widget title;
  final List<Text> content;
  final CrossAxisAlignment titleAlignment;
  final MainAxisAlignment contentMainAxisAligment;
  final CrossAxisAlignment contentCrossAxisAlignment;
  final Map<int, int> partsLayer;

  const TitleContentSlide({
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

class _TitleContentSlideState extends SlideState<TitleContentSlide> {
  final FocusNode _focusNode = FocusNode();
  int lastVisiblePart;
  bool reverseContent;

  @override
  void initState() {
    super.initState();
    lastVisiblePart = -1;
    reverseContent = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
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
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (widget.titleAlignment == CrossAxisAlignment.center ||
                        widget.titleAlignment == CrossAxisAlignment.end)
                      Spacer(),
                    DefaultTextStyle(
                      style: kTitleContentTitleTextStyle,
                      child: widget.title,
                    ),
                    if (widget.titleAlignment == CrossAxisAlignment.center ||
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
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (lastVisiblePart < widget.content.length) {
        setState(() {
          reverseContent = false;
          lastVisiblePart += 1;
        });
        return false;
      } else {
        return true;
      }
    } else if (action == kPreviousAction) {
      if (lastVisiblePart >= 0) {
        setState(() {
          reverseContent = true;
          lastVisiblePart -= 1;
        });
        return false;
      }
    }
    return true;
  }
}
