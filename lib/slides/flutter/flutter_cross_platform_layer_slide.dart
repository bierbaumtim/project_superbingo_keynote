import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:simple_animations/simple_animations.dart';

class FlutterCrossPlatformLayerSlide extends Slide {
  const FlutterCrossPlatformLayerSlide({required Key key}) : super(key: key);

  @override
  SlideState<FlutterCrossPlatformLayerSlide> createState() =>
      _FlutterCrossPlatformLayerSlideState();
}

class _FlutterCrossPlatformLayerSlideState
    extends SlideState<FlutterCrossPlatformLayerSlide>
    with TickerProviderStateMixin {
  late bool showLayer1,
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
                final smallFontsize =
                    calculateContentFontsize(constraints.maxWidth);
                final largeFontsize =
                    calculateTitleFontsize(constraints.maxWidth);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (showLayer1)
                      _LayerContainer(
                        content: 'Your code',
                        background: const Color.fromARGB(255, 180, 199, 231),
                        height: smallLayerHeight,
                        padding: const EdgeInsets.only(bottom: 8),
                        fontsize: smallFontsize,
                      ),
                    if (showLayer2)
                      _LayerContainer(
                        content: 'Flutter Framework',
                        background: const Color.fromARGB(255, 68, 114, 196),
                        height: 2 * smallLayerHeight,
                        fontsize: largeFontsize,
                      ),
                    if (showLayer3_1 || showLayer3_2)
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Visibility(
                              visible: showLayer3_1,
                              child: _LayerContainer(
                                content: 'C++ Flutter engine',
                                background:
                                    const Color.fromARGB(255, 0, 176, 80),
                                height: 2 * smallLayerHeight,
                                fontsize: largeFontsize,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Visibility(
                              visible: showLayer3_2,
                              child: _LayerContainer(
                                content: 'Flutter web engine',
                                background:
                                    const Color.fromARGB(255, 0, 176, 80),
                                height: 2 * smallLayerHeight,
                                fontsize: largeFontsize,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (showLayer4_1 || showLayer4_2 || showLayer4_3)
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Visibility(
                                    visible: showLayer4_1,
                                    child: _LayerContainer(
                                      content: 'iOS/Android runner',
                                      background: const Color.fromARGB(
                                          255, 255, 192, 0),
                                      height: smallLayerHeight,
                                      fontsize: smallFontsize,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: Visibility(
                                    visible: showLayer4_2,
                                    child: _LayerContainer(
                                      content: 'Platform-specific embedder',
                                      background: const Color.fromARGB(
                                          255, 255, 192, 0),
                                      height: smallLayerHeight,
                                      fontsize: smallFontsize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Visibility(
                              visible: showLayer4_3,
                              child: _LayerContainer(
                                content: 'Dart2js compiler',
                                background:
                                    const Color.fromARGB(255, 0, 176, 80),
                                height: smallLayerHeight,
                                fontsize: smallFontsize,
                                isOutline: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (showLayer5)
                      Row(
                        children: <Widget>[
                          const Spacer(flex: 2),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _LayerContainer(
                              content: 'Browser',
                              background:
                                  const Color.fromARGB(255, 255, 192, 0),
                              height: smallLayerHeight,
                              isOutline: true,
                              fontsize: smallFontsize,
                            ),
                          ),
                        ],
                      ),
                    if (showLayer6)
                      _LayerContainer(
                        content: 'Hardware',
                        background: const Color.fromARGB(255, 255, 0, 0),
                        height: 2 * smallLayerHeight,
                        padding: const EdgeInsets.only(top: 8),
                        fontsize: largeFontsize,
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
  final double height, fontsize;
  final EdgeInsetsGeometry? padding;
  final bool isOutline;

  const _LayerContainer({
    Key? key,
    required this.content,
    required this.background,
    required this.height,
    this.padding,
    this.isOutline = false,
    this.fontsize = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
      duration: const Duration(milliseconds: 550),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, animatedValue, child) => Opacity(
        opacity: animatedValue,
        child: child,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: isOutline ? Colors.transparent : background,
            border: isOutline
                ? Border.all(
                    width: height / 15,
                    color: background,
                  )
                : const Border(),
          ),
          constraints: BoxConstraints(
            minHeight: height,
            maxHeight: height,
          ),
          padding: EdgeInsets.all(height / 10),
          child: Center(
            child: AutoSizeText(
              content,
              maxLines: 1,
              style: kBasicTextStyle.copyWith(
                color: getContrastColor(
                  isOutline ? kSlideBackground : background,
                ),
                fontSize: fontsize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
