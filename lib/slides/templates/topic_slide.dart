import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';

class TopicSlide extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;

  const TopicSlide({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  State<TopicSlide> createState() => _TopicSlideState();
}

class _TopicSlideState extends State<TopicSlide> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSlideBackground,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final titleFontsize = constraints.maxWidth / 14;
          final subtitleFontsize = titleFontsize / 2.75;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DefaultTextStyle(
                style: kBasicTextStyle.copyWith(
                  fontSize: titleFontsize,
                ),
                child: widget.title,
              ),
              const SizedBox(height: 40),
              if (widget.subtitle != null)
                DefaultTextStyle(
                  style: kBasicTextStyle.copyWith(
                    fontSize: subtitleFontsize,
                  ),
                  child: IconTheme(
                    data: IconThemeData(size: subtitleFontsize),
                    child: widget.subtitle!,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
