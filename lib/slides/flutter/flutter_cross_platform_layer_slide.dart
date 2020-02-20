import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

class FlutterCrossPlatformLayerSlide extends Slide {
  const FlutterCrossPlatformLayerSlide({Key key}) : super(key: key);

  @override
  _FlutterCrossPlatformLayerSlideState createState() =>
      _FlutterCrossPlatformLayerSlideState();
}

class _FlutterCrossPlatformLayerSlideState
    extends SlideState<FlutterCrossPlatformLayerSlide>
    with TickerProviderStateMixin {
  bool showLayer1,
      showLayer2,
      showLayer3_1,
      showLayer3_2,
      showLayer4_1,
      showLayer4_2,
      showLayer4_3,
      showLayer5,
      showLayer6;

  @override
  void initState() {
    super.initState();
    showLayer1 = false;
    showLayer2 = false;
    showLayer3_1 = false;
    showLayer3_2 = false;
    showLayer4_1 = false;
    showLayer4_2 = false;
    showLayer4_3 = false;
    showLayer5 = false;
    showLayer6 = false;
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
          child: Padding(
            padding: const EdgeInsets.all(2 * kToolbarHeight),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final smallLayerHeight = (constraints.maxHeight - (5 * 16)) / 9;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (showLayer1)
                      _LayerContainer(
                        content: 'Your code',
                        background: Color.fromARGB(255, 180, 199, 231),
                        height: smallLayerHeight,
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                    if (showLayer2)
                      _LayerContainer(
                        content: 'Flutter Framework',
                        background: Color.fromARGB(255, 68, 114, 196),
                        height: 2 * smallLayerHeight,
                      ),
                    if (showLayer3_1 || showLayer3_2)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Visibility(
                              visible: showLayer3_1,
                              child: _LayerContainer(
                                content: 'C++ Flutter engine',
                                background: Color.fromARGB(255, 0, 176, 80),
                                height: 2 * smallLayerHeight,
                              ),
                            ),
                            flex: 2,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Visibility(
                              visible: showLayer3_2,
                              child: _LayerContainer(
                                content: 'Flutter web engine',
                                background: Color.fromARGB(255, 0, 176, 80),
                                height: 2 * smallLayerHeight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (showLayer4_1 || showLayer4_2 || showLayer4_3)
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Visibility(
                                    visible: showLayer4_1,
                                    child: _LayerContainer(
                                      content: 'iOS/Android runner',
                                      background:
                                          Color.fromARGB(255, 255, 192, 0),
                                      height: smallLayerHeight,
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Visibility(
                                    visible: showLayer4_2,
                                    child: _LayerContainer(
                                      content: 'Platform-specific embedder',
                                      background:
                                          Color.fromARGB(255, 255, 192, 0),
                                      height: smallLayerHeight,
                                    ),
                                  ),
                                  flex: 3,
                                ),
                              ],
                            ),
                            flex: 2,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Visibility(
                              visible: showLayer4_3,
                              child: _LayerContainer(
                                content: 'Dart2js compiler',
                                background: Color.fromARGB(255, 0, 176, 80),
                                height: smallLayerHeight,
                                isOutline: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (showLayer5)
                      Row(
                        children: <Widget>[
                          Spacer(
                            flex: 2,
                          ),
                          Expanded(
                            child: _LayerContainer(
                              content: 'Browser',
                              background: Color.fromARGB(255, 255, 192, 0),
                              height: smallLayerHeight,
                              isOutline: true,
                            ),
                          ),
                        ],
                      ),
                    if (showLayer6)
                      _LayerContainer(
                        content: 'Hardware',
                        background: Color.fromARGB(255, 255, 0, 0),
                        height: 2 * smallLayerHeight,
                        padding: const EdgeInsets.only(top: 8),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (!showLayer1) {
        setState(() => showLayer1 = true);
        return false;
      }
      if (!showLayer2) {
        setState(() => showLayer2 = true);
        return false;
      }
      if (!showLayer3_1) {
        setState(() => showLayer3_1 = true);
        return false;
      }
      if (!showLayer3_2) {
        setState(() => showLayer3_2 = true);
        return false;
      }
      if (!showLayer4_1) {
        setState(() => showLayer4_1 = true);
        return false;
      }
      if (!showLayer4_2) {
        setState(() => showLayer4_2 = true);
        return false;
      }
      if (!showLayer4_3) {
        setState(() => showLayer4_3 = true);
        return false;
      }
      if (!showLayer5) {
        setState(() => showLayer5 = true);
        return false;
      }
      if (!showLayer6) {
        setState(() => showLayer6 = true);
        return false;
      }
    } else if (action == kPreviousAction) {
      if (showLayer6) {
        setState(() => showLayer6 = false);
        return false;
      }
      if (showLayer5) {
        setState(() => showLayer5 = false);
        return false;
      }
      if (showLayer4_3) {
        setState(() => showLayer4_3 = false);
        return false;
      }
      if (showLayer4_2) {
        setState(() => showLayer4_2 = false);
        return false;
      }
      if (showLayer4_1) {
        setState(() => showLayer4_1 = false);
        return false;
      }
      if (showLayer3_2) {
        setState(() => showLayer3_2 = false);
        return false;
      }
      if (showLayer3_1) {
        setState(() => showLayer3_1 = false);
        return false;
      }
      if (showLayer2) {
        setState(() => showLayer2 = false);
        return false;
      }
      if (showLayer1) {
        setState(() => showLayer1 = false);
        return false;
      }
    }
    return true;
  }
}

class _LayerContainer extends StatelessWidget {
  final String content;
  final Color background;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool isOutline;

  const _LayerContainer({
    Key key,
    @required this.content,
    @required this.background,
    @required this.height,
    this.padding,
    this.isOutline = false,
  })  : assert(content != null),
        assert(background != null),
        assert(height != null),
        assert(isOutline != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: const Duration(milliseconds: 550),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, animatedValue) => Opacity(
        opacity: animatedValue,
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: isOutline ? Colors.transparent : background,
              border: isOutline
                  ? Border.all(
                      width: 3,
                      color: background,
                    )
                  : Border(),
            ),
            constraints: BoxConstraints(
              minHeight: height,
              maxHeight: height,
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: AutoSizeText(
                content,
                maxLines: 1,
                style: kBasicTextStyle.copyWith(
                  color: getContrastColor(background),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
