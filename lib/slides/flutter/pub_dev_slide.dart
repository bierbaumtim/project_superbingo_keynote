import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/widgets/revealing_text.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../main.dart';

class PackagesSlide extends Slide {
  const PackagesSlide({
    Key key,
  }) : super(key: key);

  @override
  _PackagesSlideState createState() => _PackagesSlideState();
}

class _PackagesSlideState extends SlideState with TickerProviderStateMixin {
  AnimationController sizeController, positionController;
  Animation<double> sizeFactor, xPosition;
  bool showText;
  int lastVisiblePart;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    showText = false;
    lastVisiblePart = -1;
    sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    sizeController.addListener(() {
      setState(() {});
    });
    sizeController.addStatusListener((status) {
      if (status == AnimationStatus.completed && sizeController.value == 1) {
        positionController.forward();
      }
    });
    positionController.addListener(() {
      setState(() {});
    });
    positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showText = true);
      } else if (status == AnimationStatus.dismissed) {
        sizeController.reverse();
      }
    });
    sizeFactor = Tween<double>(begin: 0.8, end: 0.5).animate(
      sizeController,
    );
    xPosition = Tween<double>(begin: 0, end: -.2).animate(
      positionController,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  void dispose() {
    sizeController.dispose();
    positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        child: Container(
          color: kSlideBackground,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              FractionalTranslation(
                translation: Offset(xPosition?.value ?? 0, 0),
                child: ChromeMockupContainer(
                  // child: WebViewContainer(),
                  sizeFactor: sizeFactor?.value ?? 0.8,
                  child: Container(),
                ),
              ),
              if (showText)
                Positioned(
                  top: MediaQuery.of(context).size.height * .4,
                  bottom: kToolbarHeight,
                  right: kToolbarHeight,
                  child: Material(
                    color: Colors.transparent,
                    child: ControlledAnimation<double>(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 750),
                      delay: const Duration(milliseconds: 250),
                      builder: (context, animation) => Opacity(
                        opacity: animation,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Center(
                            child: RevealingText(
                              lastVisiblePart: lastVisiblePart,
                              mainAxisAligment: MainAxisAlignment.start,
                              parts: <Text>[
                                Text(
                                  'OpenSource Packages und Plugins',
                                  style: theme.textTheme.bodyText2.copyWith(
                                    fontSize: 45,
                                  ),
                                ),
                                Text(
                                  'Flutter Team & Community',
                                  style: theme.textTheme.bodyText2.copyWith(
                                    fontSize: 45,
                                  ),
                                ),
                                Text(
                                  'Constributing',
                                  style: theme.textTheme.bodyText2.copyWith(
                                    fontSize: 45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (sizeController.isCompleted && positionController.isCompleted) {
        if (lastVisiblePart < 3) {
          setState(() {
            lastVisiblePart += 1;
            print(lastVisiblePart);
          });
        } else {
          return true;
        }
      } else if (sizeController.isCompleted &&
          !positionController.isCompleted) {
        positionController.forward();
      } else if (!sizeController.isCompleted) {
        sizeController.forward();
      }
    } else if (action == kPreviousAction) {
      if (lastVisiblePart != -1) {
        setState(() {
          lastVisiblePart -= 1;
          print(lastVisiblePart);
        });
      } else if (sizeController.isCompleted && positionController.isCompleted) {
        positionController.reverse();
      }
    }
    return false;
  }
}
