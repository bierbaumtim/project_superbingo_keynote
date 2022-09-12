import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';

class SuperbingoIntroSlide extends Slide {
  const SuperbingoIntroSlide({super.key});

  @override
  SlideState<SuperbingoIntroSlide> createState() =>
      _SuperbingoIntroSlideState();
}

class _SuperbingoIntroSlideState extends SlideState<SuperbingoIntroSlide> {
  @override
  Widget build(BuildContext context) {
    return const TopicSlide(
      title: Text('Superbingo'),
    );
  }

  @override
  bool handleTap(String action) {
    return true;
  }
}
