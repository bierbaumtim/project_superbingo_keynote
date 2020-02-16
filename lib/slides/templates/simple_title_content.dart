import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project_keynote/main.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

class TitleContentSlide extends Slide {
  final Widget title;
  final List<Text> content;
  final CrossAxisAlignment titleMainAxisAlignment;
  final MainAxisAlignment contentMainAxisAligment;
  final CrossAxisAlignment contentCrossAxisAlignment;

  const TitleContentSlide({
    Key key,
    this.title,
    this.content,
    this.contentMainAxisAligment = MainAxisAlignment.center,
    this.contentCrossAxisAlignment = CrossAxisAlignment.stretch,
    this.titleMainAxisAlignment = CrossAxisAlignment.center,
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
      onTap: () => handleTap('next'),
      child: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (event) {
          if (event is RawKeyUpEvent) {
            LogicalKeyboardKey logicalKey;
            bool mapCharsToArrows = false;

            if (event.data.runtimeType == RawKeyEventDataWeb) {
              final data = event.data as RawKeyEventDataWeb;
              logicalKey = data.logicalKey;
            } else if (event.data.runtimeType == RawKeyEventDataFuchsia) {
              final data = event.data as RawKeyEventDataFuchsia;
              logicalKey = data.logicalKey;
            } else if (event.data.runtimeType == RawKeyEventDataLinux) {
              final data = event.data as RawKeyEventDataFuchsia;
              logicalKey = data.logicalKey;
            } else if (event.data.runtimeType == RawKeyEventDataAndroid) {
              final data = event.data as RawKeyEventDataAndroid;
              logicalKey = data.logicalKey;
              mapCharsToArrows = true;
            }

            // print(logicalKey);
            if (logicalKey != null) {
              if (logicalKey == LogicalKeyboardKey.arrowRight ||
                  (mapCharsToArrows && logicalKey == LogicalKeyboardKey.keyK)) {
                handleTap(kNextAction);
              } else if (logicalKey == LogicalKeyboardKey.arrowLeft ||
                  (mapCharsToArrows && logicalKey == LogicalKeyboardKey.keyI)) {
                handleTap(kPreviousAction);
              }
            }
          }
        },
        child: Material(
          color: kSlideBackground,
          child: Padding(
            padding: const EdgeInsets.all(kToolbarHeight),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (widget.titleMainAxisAlignment ==
                            CrossAxisAlignment.center ||
                        widget.titleMainAxisAlignment == CrossAxisAlignment.end)
                      Spacer(),
                    DefaultTextStyle(
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.black),
                      child: widget.title,
                    ),
                    if (widget.titleMainAxisAlignment ==
                            CrossAxisAlignment.center ||
                        widget.titleMainAxisAlignment ==
                            CrossAxisAlignment.start)
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
