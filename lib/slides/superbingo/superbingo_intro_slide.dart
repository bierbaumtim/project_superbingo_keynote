import 'package:flutter/material.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';

class SuperbingoIntroSlide extends Slide {
  @override
  _SuperbingoIntroSlideState createState() => _SuperbingoIntroSlideState();
}

class _SuperbingoIntroSlideState extends SlideState<SuperbingoIntroSlide> {
  @override
  Widget build(BuildContext context) {
    return TopicSlide(
      title: Text('Superbingo'),
    );
  }

  @override
  bool handleTap(String action) {
    // TODO: implement handleTap
    throw UnimplementedError();
  }
}
