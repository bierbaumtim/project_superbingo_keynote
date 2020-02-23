import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/image_view.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/widgets/mobil_container.dart';
import 'package:simple_animations/simple_animations.dart';

class FlutterWidgetTreeSlide extends Slide {
  const FlutterWidgetTreeSlide({Key key}) : super(key: key);

  @override
  _FlutterWidgetTreeSlideState createState() => _FlutterWidgetTreeSlideState();
}

class _FlutterWidgetTreeSlideState extends SlideState<FlutterWidgetTreeSlide>
    with TickerProviderStateMixin {
  AnimationController sizeController, positionController;
  Animation<double> sizeFactor;
  Animation<Alignment> mockAlignment;
  bool showText, reverseText;
  int lastVisiblePart;

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
    mockAlignment = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment(-1, 0),
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
              final titleFontsize =
                  calculateTitleFontsize(constraints.maxWidth);
              final contentFontsize =
                  calculateContentFontsize(constraints.maxWidth);

              final maxStackWidth =
                  (constraints.maxWidth - (3 * kToolbarHeight)) / 2;
              final featureContainerWidth = constraints.maxWidth / 5;

              return Padding(
                padding: const EdgeInsets.all(1.5 * kToolbarHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: DefaultTextStyle(
                        style: kBasicTextStyle.copyWith(
                          fontSize: titleFontsize,
                        ),
                        child: Text('Widget Tree'),
                      ),
                    ),
                    SizedBox(height: kToolbarHeight),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: mockAlignment.value,
                            // child: ImageView(
                            //   sizeFactor: sizeFactor?.value ?? 0.8,
                            //   imageAssetsUrl: 'assets/chrome_dartpad_dev.png',
                            // ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: maxStackWidth,
                              ),
                              child: MobileContainer(
                                topChildConstraints: BoxConstraints(
                                  maxWidth: featureContainerWidth,
                                  minWidth: featureContainerWidth,
                                ),
                                topChild: Theme(
                                  data: ThemeData.light().copyWith(
                                    scaffoldBackgroundColor: Color(0xFF223044),
                                    appBarTheme: AppBarTheme(
                                      color: Color(0xFF152030),
                                    ),
                                  ),
                                  child: Scaffold(
                                    appBar: AppBar(
                                      title: Text('Widget Tree'),
                                    ),
                                    body: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          FlutterLogo(
                                            size: contentFontsize,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Flutter',
                                            style: kBasicTextStyle.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                backChild: Positioned(
                                  bottom: 48,
                                  left: featureContainerWidth,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: Color(0xFF152030),
                                    ),
                                    padding: const EdgeInsets.all(24),
                                    child: AutoSizeText(
                                      '''
Scaffold(
  appbar: AppBar(
    title: Text('Widget Tree'),
  ),
  body: Center(
    child: Column(
      children: <Widget>[
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(
            size: contentFontsize,
          ),
          SizedBox(height: 12),
          Text(
            'Flutter',
            style: kBasicTextStyle,
          ),
        ],
      ],
    ),
  )''',
                                      style: kBasicTextStyle.copyWith(
                                        color: Colors.white,
                                      ),
                                      maxLines: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (showText)
                            Positioned(
                              left: maxStackWidth + kToolbarHeight,
                              right: 1.5 * kToolbarHeight,
                              bottom: 1.5 * kToolbarHeight,
                              top: kToolbarHeight,
                              child: ControlledAnimation<double>(
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 750),
                                delay: const Duration(milliseconds: 250),
                                builder: (context, animation) => Opacity(
                                  opacity: animation,
                                  child: Container(
                                    width: (constraints.maxWidth -
                                            (2 * kToolbarHeight)) *
                                        0.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: _TreeItemWidget(
                                            content: 'Scaffold',
                                            textStyle: kBasicTextStyle.copyWith(
                                              fontSize: contentFontsize,
                                            ),
                                            visible: lastVisiblePart >= 0,
                                          ),
                                        ),
                                        Expanded(
                                          child: _TreeItemWidget(
                                            content: 'Center',
                                            textStyle: kBasicTextStyle.copyWith(
                                              fontSize: contentFontsize,
                                            ),
                                            visible: lastVisiblePart >= 1,
                                          ),
                                        ),
                                        Expanded(
                                          child: _TreeItemWidget(
                                            content: 'Column',
                                            textStyle: kBasicTextStyle.copyWith(
                                              fontSize: contentFontsize,
                                            ),
                                            visible: lastVisiblePart >= 2,
                                          ),
                                        ),
                                        Expanded(
                                          child: _TreeItemWidget(
                                            content: 'FlutterLogo',
                                            layer: 1,
                                            textStyle: kBasicTextStyle.copyWith(
                                              fontSize: contentFontsize,
                                            ),
                                            visible: lastVisiblePart >= 3,
                                          ),
                                        ),
                                        Expanded(
                                          child: _TreeItemWidget(
                                            content: 'SizedBox',
                                            layer: 1,
                                            textStyle: kBasicTextStyle.copyWith(
                                              fontSize: contentFontsize,
                                            ),
                                            visible: lastVisiblePart >= 4,
                                          ),
                                        ),
                                        Expanded(
                                          child: _TreeItemWidget(
                                            content: 'Text',
                                            layer: 1,
                                            textStyle: kBasicTextStyle.copyWith(
                                              fontSize: contentFontsize,
                                            ),
                                            visible: lastVisiblePart >= 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
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
        if (lastVisiblePart < 5) {
          setState(() {
            reverseText = false;
            lastVisiblePart += 1;
            print(lastVisiblePart);
          });
        } else {
          return true;
        }
      } else if (!sizeController.isCompleted) {
        sizeController.forward();
      } else if (sizeController.isCompleted &&
          !positionController.isCompleted) {
        positionController.forward();
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

class _TreeItemWidget extends StatelessWidget {
  final String content;
  final int layer;
  final TextStyle textStyle;
  final bool visible;

  const _TreeItemWidget({
    Key key,
    @required this.content,
    this.layer = 0,
    this.textStyle,
    this.visible = false,
  })  : assert(content != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return ControlledAnimation(
        duration: const Duration(milliseconds: 550),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, animtedValue) => Opacity(
          opacity: animtedValue,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: Color.fromARGB(
                  255,
                  47,
                  82,
                  143,
                ),
                // color: Color(0xFF223044),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: AutoSizeText(
                  content,
                  style: textStyle ?? kBasicTextStyle,
                ),
              ),
            ),
            margin: EdgeInsets.fromLTRB(layer * 72.0, 16, 0, 16),
            constraints: BoxConstraints(
              minWidth: 300,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
