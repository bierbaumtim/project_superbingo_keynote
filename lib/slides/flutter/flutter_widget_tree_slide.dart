import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/widgets/mobil_container.dart';
import 'package:project_keynote/widgets/tree_item_widget.dart';
import 'package:simple_animations/simple_animations.dart';

class FlutterWidgetTreeSlide extends Slide {
  const FlutterWidgetTreeSlide({required Key key}) : super(key: key);

  @override
  _FlutterWidgetTreeSlideState createState() => _FlutterWidgetTreeSlideState();
}

class _FlutterWidgetTreeSlideState extends SlideState<FlutterWidgetTreeSlide>
    with TickerProviderStateMixin {
  late AnimationController positionController;
  late Animation<Alignment> mockAlignment;
  late bool showText, reverseText;
  late int lastVisiblePart;

  @override
  void initState() {
    super.initState();
    showText = false;
    reverseText = false;
    lastVisiblePart = -1;
    positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    positionController.addListener(() {
      setState(() {});
    });
    positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showText = true);
      } else if (status == AnimationStatus.dismissed) {
        setState(() => showText = false);
      }
    });
    mockAlignment = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment(-1, 0),
    ).animate(
      positionController,
    );
  }

  @override
  void dispose() {
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
                              child: PlayAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 750),
                                delay: const Duration(milliseconds: 250),
                                builder: (_, animation, child) => Opacity(
                                  opacity: animation,
                                  child: child,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: 'Scaffold',
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        visible: lastVisiblePart >= 0,
                                      ),
                                    ),
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: '...',
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        layer: 1,
                                        visible: lastVisiblePart >= 1,
                                      ),
                                    ),
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: 'Center',
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        layer: 1,
                                        visible: lastVisiblePart >= 2,
                                      ),
                                    ),
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: 'Column',
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        layer: 1,
                                        visible: lastVisiblePart >= 3,
                                      ),
                                    ),
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: 'FlutterLogo',
                                        layer: 2,
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        visible: lastVisiblePart >= 4,
                                      ),
                                    ),
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: 'SizedBox',
                                        layer: 2,
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        visible: lastVisiblePart >= 5,
                                      ),
                                    ),
                                    Expanded(
                                      child: TreeItemWidget(
                                        content: 'Text',
                                        layer: 2,
                                        textStyle: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                        visible: lastVisiblePart >= 6,
                                      ),
                                    ),
                                  ],
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
      if (positionController.isCompleted) {
        if (lastVisiblePart < 6) {
          setState(() {
            reverseText = false;
            lastVisiblePart += 1;
            print(lastVisiblePart);
          });
        } else {
          return true;
        }
      } else {
        positionController.forward();
      }
    } else if (action == kPreviousAction) {
      if (lastVisiblePart != -1) {
        setState(() {
          reverseText = true;
          lastVisiblePart -= 1;
          print(lastVisiblePart);
        });
      } else if (positionController.isCompleted) {
        positionController.reverse();
      } else if (positionController.isDismissed) {
        return true;
      }
    }
    return false;
  }
}
