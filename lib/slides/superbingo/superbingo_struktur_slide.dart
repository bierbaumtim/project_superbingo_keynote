import 'dart:math';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/constants.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

const kDBOrange = Color.fromARGB(255, 255, 192, 0);

const backGreen = Color.fromARGB(255, 0, 176, 80);
const borderGreen = Color.fromARGB(255, 84, 130, 53);

const backBlue = Color.fromARGB(255, 68, 114, 196);
const borderBlue = Color.fromARGB(255, 47, 82, 143);

class SuperbingoStrukturSlide extends Slide {
  const SuperbingoStrukturSlide({Key key}) : super(key: key);

  @override
  _SuperbingoStrukturSlideState createState() =>
      _SuperbingoStrukturSlideState();
}

class _SuperbingoStrukturSlideState extends SlideState<SuperbingoStrukturSlide>
    with TickerProviderStateMixin {
  int lastVisiblePart;

  @override
  void initState() {
    super.initState();
    lastVisiblePart = -1;
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
                  calculateContentFontsize(constraints.maxWidth) * 0.75;

              final dbHeight =
                  (constraints.maxHeight - (2 * kToolbarHeight)) / 9;

              final arrowPadding = contentFontsize * kBasicTextStyle.height;

              return Padding(
                padding: const EdgeInsets.all(1.5 * kToolbarHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: kBasicTextStyle.copyWith(
                        fontSize: titleFontsize,
                      ),
                      child: Text('Struktur'),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          if (lastVisiblePart >= 0)
                            ControlledAnimation<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: kFadeInDuration,
                              builder: (buildContext, animatedValue) => Opacity(
                                opacity: animatedValue,
                                child: CustomPaint(
                                  painter: _DBPainter(),
                                  child: Container(
                                    height: dbHeight,
                                    width: dbHeight * 2.3,
                                    child: Center(
                                      child: AutoSizeText(
                                        'Firestore',
                                        maxLines: 1,
                                        style: kBasicTextStyle.copyWith(
                                          fontSize: contentFontsize,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (lastVisiblePart >= 1)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: contentFontsize,
                                ),
                                child: Center(
                                  child: CustomPaint(
                                    painter: _GradientArrowPainter(
                                      <Color>[
                                        kDBOrange,
                                        backBlue,
                                      ],
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Spacer(),
                          if (lastVisiblePart >= 2)
                            ControlledAnimation<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: kFadeInDuration,
                              builder: (buildContext, animatedValue) => Opacity(
                                opacity: animatedValue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: backBlue,
                                    border: Border.all(
                                      color: borderBlue,
                                      width: 2,
                                    ),
                                  ),
                                  child: AutoSizeText(
                                    '\n   NetworkService   \n',
                                    style: kBasicTextStyle.copyWith(
                                      fontSize: contentFontsize,
                                      color: getContrastColor(backBlue),
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            )
                          else
                            Spacer(),
                          if (lastVisiblePart >= 3)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: contentFontsize,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Transform.rotate(
                                        angle: -pi / 6,
                                        child: CustomPaint(
                                          painter: _GradientArrowPainter(
                                            <Color>[
                                              backBlue,
                                              backGreen,
                                            ],
                                          ),
                                          child: SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3 * arrowPadding),
                                    Center(
                                      child: CustomPaint(
                                        painter: _GradientArrowPainter(
                                          <Color>[
                                            backBlue,
                                            backGreen,
                                          ],
                                        ),
                                        child: SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3 * arrowPadding),
                                    Center(
                                      child: Transform.rotate(
                                        angle: pi / 6,
                                        child: CustomPaint(
                                          painter: _GradientArrowPainter(
                                            <Color>[
                                              backBlue,
                                              backGreen,
                                            ],
                                          ),
                                          child: SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Spacer(),
                          if (lastVisiblePart >= 4)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ControlledAnimation<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: kFadeInDuration,
                                  builder: (buildContext, animatedValue) =>
                                      Opacity(
                                    opacity: animatedValue,
                                    child: _BlocContainer(
                                      contentFontsize: contentFontsize,
                                    ),
                                  ),
                                ),
                                ControlledAnimation<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: kFadeInDuration,
                                  delay: const Duration(milliseconds: 550),
                                  builder: (buildContext, animatedValue) =>
                                      Opacity(
                                    opacity: animatedValue,
                                    child: _BlocContainer(
                                      contentFontsize: contentFontsize,
                                    ),
                                  ),
                                ),
                                ControlledAnimation<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: kFadeInDuration,
                                  delay: const Duration(milliseconds: 1100),
                                  builder: (buildContext, animatedValue) =>
                                      Opacity(
                                    opacity: animatedValue,
                                    child: _BlocContainer(
                                      contentFontsize: contentFontsize,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Spacer(),
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
      if (lastVisiblePart < 4) {
        setState(() => lastVisiblePart++);
        return false;
      }
    } else if (action == kPreviousAction) {
      if (lastVisiblePart >= 0) {
        setState(() => lastVisiblePart--);
      }
      return false;
    }
    return true;
  }
}

class _BlocContainer extends StatelessWidget {
  const _BlocContainer({
    Key key,
    @required this.contentFontsize,
  }) : super(key: key);

  final double contentFontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backGreen,
        border: Border.all(
          color: borderGreen,
          width: 2,
        ),
      ),
      child: AutoSizeText(
        '\n      BLoC      \n',
        style: kBasicTextStyle.copyWith(
          fontSize: contentFontsize,
          color: getContrastColor(backGreen),
        ),
        maxLines: 3,
      ),
    );
  }
}

class _DBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = kDBOrange
      ..isAntiAlias = true;
    final borderPaint = Paint()
      ..color = kDBOrange
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final litePaint = Paint()
      ..color = Color.fromARGB(255, 255, 217, 102)
      ..isAntiAlias = true;

    final height = 2 * size.height;
    final width = size.width;
    final ovalHeight = size.height / 2;

    canvas.drawRect(
      Rect.fromLTRB(0, -size.height, width, height),
      mainPaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(
        0.75,
        (height - (ovalHeight / 2)),
        width - 1.5,
        ovalHeight,
      ),
      0,
      90,
      false,
      mainPaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(
        0.75,
        -(size.height + (ovalHeight / 2)),
        width - 1.5,
        ovalHeight,
      ),
      0,
      90,
      false,
      litePaint,
    );

    canvas.drawArc(
      Rect.fromLTWH(
        0.75,
        -(size.height + (ovalHeight / 2)),
        width - 1.5,
        ovalHeight,
      ),
      0,
      90,
      false,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _GradientArrowPainter extends CustomPainter {
  final List<Color> colors;

  _GradientArrowPainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final gradientPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, 0),
        colors,
      );

    final arrowPath = Path();

    final arrowLength = size.width / 8;
    final rectHeight = size.height / 4;
    final center = size.height / 2;

    arrowPath.moveTo(0, center);
    // Left top arrow part
    arrowPath.lineTo(arrowLength, 0);
    arrowPath.lineTo(arrowLength, rectHeight);
    // Center top rect part
    arrowPath.lineTo(size.width - arrowLength, rectHeight);
    // right top arrow part
    arrowPath.lineTo(size.width - arrowLength, 0);
    arrowPath.lineTo(size.width, center);
    // right bottom arrow part
    arrowPath.lineTo(size.width - arrowLength, size.height);
    arrowPath.lineTo(size.width - arrowLength, size.height * (3 / 4));
    // Center bottom rect part
    arrowPath.lineTo(arrowLength, size.height * (3 / 4));
    // left bottom arrow part
    arrowPath.lineTo(arrowLength, size.height);

    arrowPath.close();

    canvas.drawPath(arrowPath, gradientPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
