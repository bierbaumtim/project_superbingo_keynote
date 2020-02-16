import 'package:flutter/material.dart';
import 'package:project_keynote/constants.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';

class FlutterIntroSlide extends Slide {
  const FlutterIntroSlide({Key key}) : super(key: key);

  @override
  _FlutterIntroSlideState createState() => _FlutterIntroSlideState();
}

class _FlutterIntroSlideState extends SlideState<FlutterIntroSlide> {
  @override
  Widget build(BuildContext context) {
    return TopicSlide(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Hero(
            tag: kFlutterLogoHeroTag,
            child: FlutterLogo(
              size: 100,
            ),
          ),
          Text('Flutter'),
        ],
      ),
    );
  }

  @override
  bool handleTap(String action) {
    debugPrint('FlutterIntroSlide completed');
    return true;
  }
}
