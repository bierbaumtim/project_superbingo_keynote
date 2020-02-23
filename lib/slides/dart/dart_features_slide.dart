import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/revealing_text.dart';

class DartFeaturesSlide extends StatefulWidget {
  const DartFeaturesSlide({Key key}) : super(key: key);

  @override
  _DartFeaturesSlideState createState() => _DartFeaturesSlideState();
}

class _DartFeaturesSlideState extends SlideState<DartFeaturesSlide> {
  PageController pageController;
  int firstPageLastVisiblePart, secondPageLastVisiblePart;
  bool firstPageReverseText, secondPageReverseText;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    firstPageLastVisiblePart = -1;
    firstPageReverseText = false;
    secondPageLastVisiblePart = -1;
    secondPageReverseText = false;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleTap('next'),
      child: KeyboardHandler(
        onKeyboardTap: handleTap,
        child: Material(
          color: kSlideBackground,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final titleFontsize =
                  calculateTitleFontsize(constraints.maxWidth);
              final contentFontsize =
                  calculateContentFontsize(constraints.maxWidth) * 0.75;

              final featureContainerWidth = constraints.maxWidth / 5;

              return Padding(
                padding: const EdgeInsets.all(1.5 * kToolbarHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: kBasicTextStyle.copyWith(
                        fontSize: titleFontsize,
                      ),
                      child: Text('Dart Features'),
                    ),
                    SizedBox(height: kToolbarHeight),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: _MobileContainer(
                                  topChild: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: featureContainerWidth,
                                      minWidth: featureContainerWidth,
                                    ),
                                    child: ListView(
                                      children: <Widget>[
                                        Placeholder(),
                                        Padding(
                                          padding: const EdgeInsets.all(24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.all(4),
                                                height: 30,
                                                color: Color(0xFF5989F1),
                                              ),
                                              for (var i = 0; i <= 4; i++)
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                  height: 10.0 * i,
                                                  width: 90.0 * i,
                                                  color: Color(0xFF5989F1),
                                                ),
                                              ...[
                                                Text(
                                                  '1',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '2',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '3',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  '4',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ]
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  topChildConstraints: BoxConstraints(
                                    maxWidth: featureContainerWidth,
                                    minWidth: featureContainerWidth,
                                  ),
                                  backChild: Positioned(
                                    bottom: 48,
                                    left: featureContainerWidth,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Color(0xFF152030),
                                      ),
                                      padding: const EdgeInsets.all(24),
                                      child: AutoSizeText(
                                        '''
Column(
  crossAxisAlignment: 
    CrossAxisAlignment.start,
    children: <Widget>[
      Placeholder(),
      HeaderContainer(),
      for (var i = 0; i <= 4; i++) 
        ColorContainer(index: i),
      ...[
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4')
      ],
    ],
  )''',
                                        style: kBasicTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                        maxLines: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: kToolbarHeight),
                              Expanded(
                                child: RevealingText(
                                  parts: <Text>[
                                    Text('spread operator'),
                                    Text('collection if'),
                                    Text('collection for'),
                                  ],
                                  lastVisiblePart: firstPageLastVisiblePart,
                                  defaultTextStyle: kBasicTextStyle.copyWith(
                                    fontSize: contentFontsize,
                                  ),
                                  reverse: firstPageReverseText,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFF152030),
                                  ),
                                  padding: const EdgeInsets.all(24),
                                  child: Text(
                                    '''
extension StringParser on String {

  int toInt() => int.parse(this);

}

final v = '4'.toInt();

extension numX on num {
  num limitTo(num limit) => this <= limit ? this : limit;
}
''',
                                    style: kBasicTextStyle.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: kToolbarHeight),
                              Expanded(
                                child: RevealingText(
                                  parts: <Text>[
                                    Text('statische Erweiterungen'),
                                    Text('generische Erweiterungen'),
                                    Text('getter, setter und operatoren'),
                                  ],
                                  lastVisiblePart: secondPageLastVisiblePart,
                                  defaultTextStyle: kBasicTextStyle.copyWith(
                                    fontSize: contentFontsize,
                                  ),
                                  reverse: secondPageReverseText,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      if (pageController.page == 0) {
        if (firstPageLastVisiblePart < 2) {
          setState(() {
            firstPageReverseText = false;
            firstPageLastVisiblePart++;
          });
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 550),
            curve: Curves.easeInOut,
          );
        }
        return false;
      }
      if (pageController.page == 1) {
        if (secondPageLastVisiblePart < 2) {
          setState(() {
            secondPageReverseText = false;
            secondPageLastVisiblePart++;
          });
          return false;
        }
      }
    } else if (action == kPreviousAction) {
      if (pageController.page == 0) {
        if (firstPageLastVisiblePart >= 0) {
          setState(() {
            firstPageReverseText = true;
            firstPageLastVisiblePart--;
          });
          return false;
        }
      }
      if (pageController.page == 1) {
        if (secondPageLastVisiblePart >= 0) {
          setState(() {
            secondPageReverseText = true;
            secondPageLastVisiblePart--;
          });
          return false;
        } else {
          pageController.previousPage(
            duration: const Duration(milliseconds: 550),
            curve: Curves.easeInOut,
          );
          return false;
        }
      }
    }
    return true;
  }
}

class _MobileContainer extends StatelessWidget {
  final Widget topChild;
  final Widget backChild;
  final BoxConstraints topChildConstraints;

  const _MobileContainer({
    Key key,
    this.topChild,
    this.backChild,
    this.topChildConstraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (backChild != null) backChild,
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF223044),
              borderRadius: BorderRadius.circular(40),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[850],
                  blurRadius: 10,
                ),
              ],
            ),
            constraints: topChildConstraints,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: topChild,
            ),
            margin: const EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
