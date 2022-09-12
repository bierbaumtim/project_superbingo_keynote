import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/animated_title_content.dart';

class EverythingIsAWidgetSlide extends Slide {
  const EverythingIsAWidgetSlide({super.key});

  @override
  SlideState<EverythingIsAWidgetSlide> createState() =>
      _EverythingIsAWidgetSlieState();
}

class _EverythingIsAWidgetSlieState
    extends SlideState<EverythingIsAWidgetSlide> {
  static const _innerTemplateKey =
      GlobalObjectKey<SlideState>('everything_is_a_widget__inerTemplate');

  @override
  Widget build(BuildContext context) {
    return const AnimatedTitleContentSlide(
      key: _innerTemplateKey,
      title: Text('Everything is a Widget'),
      content: <Text>[
        Text('Kleinste Element der UI'),
        Text('Beschreibung: Was? Wie? Wo? Wann?'),
        Text('Viele, kleine, vordefinierte Widgets'),
        Text('2 Widget Pakete'),
        Text('Material'),
        Text('Cupertino'),
      ],
      partsLayer: <int, int>{
        4: 1,
        5: 1,
      },
      titleAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  bool handleTap(String action) =>
      _innerTemplateKey.currentState?.handleTap(action) ?? false;
}
