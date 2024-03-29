import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/templates/animated_title_content.dart';

class FlutterCrossPlatformSlide extends Slide {
  const FlutterCrossPlatformSlide({required Key key}) : super(key: key);

  @override
  SlideState<FlutterCrossPlatformSlide> createState() =>
      _FlutterCrossPlatformSlideState();
}

class _FlutterCrossPlatformSlideState
    extends SlideState<FlutterCrossPlatformSlide> {
  static const _innerTemplateKey =
      GlobalObjectKey<SlideState>('flutter_cross_platform__innerTemplate');

  @override
  Widget build(BuildContext context) {
    return AnimatedTitleContentSlide(
      key: _innerTemplateKey,
      // title: Text.rich(
      //   TextSpan(
      //     children: <InlineSpan>[
      //       TextSpan(text: 'Flutter '),
      //       WidgetSpan(
      //         child: Icon(
      //           Icons.favorite_border,
      //           color: Colors.red,
      //           size: 80,
      //         ),
      //       ),
      //       TextSpan(text: ' Cross Platform'),
      //     ],
      //   ),
      // ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          Text('Flutter '),
          Icon(
            Icons.favorite_border,
            color: Colors.red,
            size: 80,
          ),
          Text(' Cross Platform'),
        ],
      ),
      content: const <Text>[
        Text('Mobile - iOS und Android'),
        Text('Web - Beta'),
        Text('Desktop - Alpha und WIP'),
      ],
      titleAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  bool handleTap(String action) =>
      _innerTemplateKey.currentState?.handleTap(action) ?? false;
}
