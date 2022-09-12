import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/animated_title_content.dart';

class SuperbingoOptimierungenSide extends Slide {
  const SuperbingoOptimierungenSide({required Key key}) : super(key: key);

  @override
  SlideState<SuperbingoOptimierungenSide> createState() =>
      _SuperbingoOptimierungenSideState();
}

class _SuperbingoOptimierungenSideState
    extends SlideState<SuperbingoOptimierungenSide> {
  static const _innerTemplateKey =
      GlobalObjectKey<SlideState>('superbingo_optimierungen_innertemplate');

  @override
  Widget build(BuildContext context) {
    return const AnimatedTitleContentSlide(
      key: _innerTemplateKey,
      titleAlignment: CrossAxisAlignment.start,
      title: Text('What\'s next?'),
      content: <Text>[
        Text('UI verfeinern'),
        Text('UI für andere Formfaktoren erstellen'),
        Text('Netzwerkoperationen optimieren'),
        Text('Unit testing'),
      ],
    );
  }

  @override
  bool handleTap(String action) =>
      _innerTemplateKey.currentState?.handleTap(action) ?? false;
}
