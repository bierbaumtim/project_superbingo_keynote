import 'package:project_keynote/constants.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';

class IntroSlide extends Slide {
  const IntroSlide({super.key});

  @override
  SlideState<IntroSlide> createState() => _IntroSlideState();
}

class _IntroSlideState extends SlideState<IntroSlide> {
  @override
  Widget build(BuildContext context) {
    return KeyboardHandler(
      onKeyboardTap: handleTap,
      child: TopicSlide(
        title: const Text('Superbingo'),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Built with '),
            Row(
              children: const <Widget>[
                Hero(
                  tag: kFlutterLogoHeroTag,
                  child: FlutterLogo(),
                ),
                Text('Flutter'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) => true;
}
