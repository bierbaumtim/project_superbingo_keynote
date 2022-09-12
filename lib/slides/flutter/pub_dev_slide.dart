import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/chrome_mock_container.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

import 'package:simple_animations/simple_animations.dart';

class PackagesSlide extends Slide {
  const PackagesSlide({required Key key}) : super(key: key);

  @override
  _PackagesSlideState createState() => _PackagesSlideState();
}

class _PackagesSlideState extends SlideState<PackagesSlide>
    with TickerProviderStateMixin {
  late AnimationController sizeController, positionController;
  late Animation<double> sizeFactor;
  late Animation<Alignment> mockAligment;
  late bool showText, reverseText;
  late int lastVisiblePart;

  @override
  void initState() {
    super.initState();
    showText = false;
    reverseText = false;
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
        setState(() => showText = false);
        sizeController.reverse();
      }
    });
    sizeFactor = Tween<double>(begin: 0.8, end: 0.5).animate(
      sizeController,
    );
    mockAligment = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment(-0.8, 0),
    ).animate(
      positionController,
    );
  }

  @override
  void dispose() {
    sizeController.dispose();
    positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleTap('next'),
      child: KeyboardHandler(
        onKeyboardTap: handleTap,
        child: Material(
          color: kSlideBackground,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentFontsize =
                  calculateContentFontsize(constraints.maxWidth);

              return Stack(
                children: <Widget>[
                  Align(
                    alignment: mockAligment.value,
                    child: ChromeMockupContainer(
                      child: const SizedBox(),
                      // child: WebViewContainer(),
                      sizeFactor: sizeFactor.value,
                      imageAssetsUrl: 'assets/chrome_mockup_dark.png',
                    ),
                  ),
                  if (showText)
                    Positioned(
                      top: kToolbarHeight,
                      bottom: kToolbarHeight,
                      right: kToolbarHeight,
                      child: PlayAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 750),
                        delay: const Duration(milliseconds: 250),
                        builder: (context, animation, child) => Opacity(
                          opacity: animation,
                          child: child,
                        ),
                        child: Container(
                          width: (constraints.maxWidth - (2 * kToolbarHeight)) *
                              0.35,
                          child: Center(
                            child: RevealingText(
                              lastVisiblePart: lastVisiblePart,
                              reverse: reverseText,
                              parts: <Text>[
                                Text(
                                  'OpenSource Packages und Plugins',
                                  style: kBasicTextStyle.copyWith(
                                    fontSize: contentFontsize,
                                  ),
                                ),
                                Text(
                                  'Flutter Team & Community',
                                  style: kBasicTextStyle.copyWith(
                                    fontSize: contentFontsize,
                                  ),
                                ),
                                Text(
                                  'Constributing',
                                  style: kBasicTextStyle.copyWith(
                                    fontSize: contentFontsize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (sizeController.isCompleted && positionController.isCompleted) {
        if (lastVisiblePart < 2) {
          setState(() {
            reverseText = false;
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
          reverseText = true;
          lastVisiblePart -= 1;
          print(lastVisiblePart);
        });
      } else if (sizeController.isCompleted && positionController.isCompleted) {
        positionController.reverse();
      } else if (sizeController.isDismissed && positionController.isDismissed) {
        return true;
      }
    }
    return false;
  }
}
