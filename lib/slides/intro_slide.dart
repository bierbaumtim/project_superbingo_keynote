import 'package:flutter/material.dart';
import 'package:project_keynote/constants.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';
import 'package:project_keynote/text_styles.dart';

class IntroSlide extends Slide {
  @override
  _IntroSlideState createState() => _IntroSlideState();
}

class _IntroSlideState extends SlideState<IntroSlide> {
  @override
  Widget build(BuildContext context) {
    return TopicSlide(
      title: Text('Superbingo'),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Built with '),
          Row(
            children: <Widget>[
              Hero(
                tag: kFlutterLogoHeroTag,
                child: FlutterLogo(
                  size: 48,
                ),
              ),
              Text('Flutter'),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool handleTap(String action) {
    // TODO: implement handleTap
    throw UnimplementedError();
  }
}
