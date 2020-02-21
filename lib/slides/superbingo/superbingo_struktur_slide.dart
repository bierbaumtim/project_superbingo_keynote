import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';

class SuperbingoStrukturSlide extends Slide {
  const SuperbingoStrukturSlide({Key key}) : super(key: key);

  @override
  _SuperbingoStrukturSlideState createState() =>
      _SuperbingoStrukturSlideState();
}

class _SuperbingoStrukturSlideState extends SlideState<SuperbingoStrukturSlide>
    with TickerProviderStateMixin {
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

              final backBlue = Color.fromARGB(255, 68, 114, 196);
              final borderBlue = Color.fromARGB(255, 47, 82, 143);

              final dbHeight =
                  (constraints.maxHeight - (2 * kToolbarHeight)) / 9;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      1.5 * kToolbarHeight,
                      1.5 * kToolbarHeight,
                      1.5 * kToolbarHeight,
                      0,
                    ),
                    child: DefaultTextStyle(
                      style: kBasicTextStyle.copyWith(
                        fontSize: titleFontsize,
                      ),
                      child: Text('Struktur'),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(-0.75, -0.1),
                          child: CustomPaint(
                            painter: _DBPainter(),
                            child: Container(
                              height: dbHeight,
                              width: dbHeight * 2.3,
                              child: Center(
                                child: AutoSizeText(
                                  'Firestore',
                                  style: kBasicTextStyle.copyWith(
                                    fontSize: contentFontsize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, -0.1),
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
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0.9, -0.1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _BlocContainer(
                                contentFontsize: contentFontsize,
                              ),
                              _BlocContainer(
                                contentFontsize: contentFontsize,
                              ),
                              _BlocContainer(
                                contentFontsize: contentFontsize,
                              ),
                            ],
                          ),
                        ),
                      ],
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
    // TODO: implement handleTap
    throw UnimplementedError();
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
    final backGreen = Color.fromARGB(255, 0, 176, 80);
    final borderGreen = Color.fromARGB(255, 84, 130, 53);

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
      ),
    );
  }
}

class _DBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint()
      ..color = Color.fromARGB(255, 255, 192, 0)
      ..isAntiAlias = true;
    final borderPaint = Paint()
      ..color = Color.fromARGB(255, 255, 192, 0)
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
