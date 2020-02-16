import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';

class TopicSlide extends StatefulWidget {
  final Widget title;
  final Widget subtitle;

  const TopicSlide({
    Key key,
    @required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  _TopicSlideState createState() => _TopicSlideState();
}

class _TopicSlideState extends State<TopicSlide> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSlideBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DefaultTextStyle(
            style: kTopicTitleTextStyle,
            child: widget.title,
          ),
          SizedBox(height: 40),
          if (widget.subtitle != null)
            DefaultTextStyle(
              style: kTopicSubtitleTextStyle,
              child: widget.subtitle,
            ),
        ],
      ),
    );
  }
}
