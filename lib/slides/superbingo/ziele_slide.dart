import 'package:project_keynote/slide.dart';

import 'package:project_keynote/slides/templates/simple_title_content.dart';

class ZielSlide extends Slide {
  const ZielSlide({GlobalKey<SlideState>? key}) : super(key: key);

  @override
  SlideState<ZielSlide> createState() => _ZielSlideState();
}

class _ZielSlideState extends SlideState<ZielSlide> {
  static const GlobalObjectKey<SlideState> _innerTemplateKey =
      GlobalObjectKey<SlideState>('innerTemplateKey');

  @override
  Widget build(BuildContext context) {
    return const TitleContentSlide(
      key: _innerTemplateKey,
      title: Text('Ziel'),
      content: <Text>[
        Text('Erste Version'),
        Text('Grundlegende Funktionen'),
        Text('Wenige bis keine Animationen'),
        Text('Layout für Mobile'),
      ],
      contentMainAxisAligment: MainAxisAlignment.start,
      titleAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  bool handleTap(String action) =>
      _innerTemplateKey.currentState?.handleTap(action) ?? false;
}
