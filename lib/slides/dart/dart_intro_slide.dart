import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';
import 'package:project_keynote/text_styles.dart';

class DartIntroSlide extends StatefulWidget {
  const DartIntroSlide({Key key}) : super(key: key);

  @override
  _DartIntroSldieState createState() => _DartIntroSldieState();
}

class _DartIntroSldieState extends SlideState<DartIntroSlide> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleFontsize = calculateTitleFontsize(constraints.maxWidth);

        return TopicSlide(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: titleFontsize * kBasicTextStyle.height,
                height: titleFontsize * kBasicTextStyle.height,
                child: Image.asset('assets/dart_logo.png'),
              ),
              Text(' Dart'),
            ],
          ),
        );
      },
    );
  }

  @override
  bool handleTap(String action) => true;
}
