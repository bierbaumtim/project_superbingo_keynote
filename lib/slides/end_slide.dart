import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/topic_slide.dart';

class EndSlide extends StatefulWidget {
  const EndSlide({super.key});

  @override
  _EndSlideState createState() => _EndSlideState();
}

class _EndSlideState extends SlideState<EndSlide> {
  @override
  Widget build(BuildContext context) {
    return TopicSlide(
      title: Text(
        'Vielen Dank für eure Aufmerksamkeit',
        textAlign: TextAlign.center,
      ),
      subtitle: Text('Gibt es noch Fragen?'),
    );
  }

  @override
  bool handleTap(String action) => true;
}
