import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';
import 'package:project_keynote/widgets/mobil_container.dart';
import 'package:project_keynote/widgets/tree_item_widget.dart';

class FlutterWidgetElementTreeSlide extends Slide {
  const FlutterWidgetElementTreeSlide({required Key key}) : super(key: key);

  @override
  _FlutterWidgetElementTreeSlideState createState() =>
      _FlutterWidgetElementTreeSlideState();
}

class _FlutterWidgetElementTreeSlideState
    extends SlideState<FlutterWidgetElementTreeSlide>
    with TickerProviderStateMixin {
  late AnimationController positionController;
  late Animation<Alignment> mockAlignment;
  late bool showWidgetTree, showElementTree, showStateObjects;
  late int counter, stackIndex;

  @override
  void initState() {
    super.initState();
    showWidgetTree = false;
    showElementTree = false;
    showStateObjects = false;
    counter = 0;
    stackIndex = 0;
    positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    positionController.addListener(() {
      setState(() {});
    });
    positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // showWidgetTree = true;
          stackIndex = 1;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() => showWidgetTree = false);
      }
    });
    mockAlignment = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment(-1, 0),
    ).animate(
      positionController,
    );
  }

  @override
  void dispose() {
    positionController.dispose();
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

              final featureContainerWidth = constraints.maxWidth / 5;

              final contentFontsize = calculateContentFontsize(
                constraints.maxWidth - featureContainerWidth,
              );

              return Padding(
                padding: const EdgeInsets.all(1.5 * kToolbarHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: DefaultTextStyle(
                        style: kBasicTextStyle.copyWith(
                          fontSize: titleFontsize,
                        ),
                        child: Text('Widget und Element Tree'),
                      ),
                    ),
                    SizedBox(height: kToolbarHeight),
                    Expanded(
                      child: IndexedStack(
                        index: stackIndex,
                        children: <Widget>[
                          _Sample(
                            counter: counter,
                            featureContainerWidth: featureContainerWidth,
                            alignment: mockAlignment.value,
                            floatingHeroTag: '',
                          ),
                          Row(
                            children: <Widget>[
                              _Sample(
                                counter: counter,
                                featureContainerWidth: featureContainerWidth,
                                floatingHeroTag: '',
                              ),
                              SizedBox(width: kToolbarHeight),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TreesRow(
                                        contentFontsize: contentFontsize,
                                        elementName: 'StatefulElement',
                                        widgetName: 'MyWidget',
                                        showWidget: showWidgetTree,
                                        showElement: showElementTree,
                                        showStateObject: showStateObjects,
                                      ),
                                      TreesRow(
                                        contentFontsize: contentFontsize,
                                        elementName: 'StatefulElement',
                                        widgetName: 'Scaffold',
                                        showWidget: showWidgetTree,
                                        showElement: showElementTree,
                                        showStateObject: showStateObjects,
                                        layer: 1,
                                      ),
                                      TreesRow(
                                        contentFontsize: contentFontsize,
                                        elementName: '...',
                                        widgetName: '...',
                                        showWidget: showWidgetTree,
                                        showElement: showElementTree,
                                        layer: 2,
                                      ),
                                      TreesRow(
                                        contentFontsize: contentFontsize,
                                        elementName: 'StatelessElement',
                                        widgetName: 'Center',
                                        showWidget: showWidgetTree,
                                        showElement: showElementTree,
                                        layer: 2,
                                      ),
                                      TreesRow(
                                        contentFontsize: contentFontsize,
                                        elementName: 'StatelessElement',
                                        widgetName: 'Column',
                                        showWidget: showWidgetTree,
                                        showElement: showElementTree,
                                        layer: 2,
                                      ),
                                      TreesRow(
                                        contentFontsize: contentFontsize,
                                        elementName: 'StatelessElement',
                                        widgetName: 'Text',
                                        showWidget: showWidgetTree,
                                        showElement: showElementTree,
                                        layer: 3,
                                      ),
                                    ],
                                  ),
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
      if (positionController.isCompleted) {
        if (!showWidgetTree) {
          setState(() {
            showWidgetTree = true;
          });
          return false;
        } else if (!showElementTree) {
          setState(() {
            showElementTree = true;
          });
          return false;
        } else if (!showStateObjects) {
          setState(() {
            showStateObjects = true;
          });
          return false;
        } else if (counter < 2) {
          setState(() {
            counter++;
          });
          return false;
        } else {
          return true;
        }
      } else {
        positionController.forward();
      }
    } else if (action == kPreviousAction) {
      if (counter > 0) {
        setState(() {
          counter--;
        });
        return false;
      }
      if (showStateObjects) {
        setState(() {
          showStateObjects = false;
        });
        return false;
      } else if (showElementTree) {
        setState(() {
          showElementTree = false;
        });
        return false;
      } else if (showWidgetTree) {
        setState(() {
          showWidgetTree = false;
          stackIndex = 0;
        });
        return false;
      } else if (positionController.isCompleted) {
        setState(() {
          stackIndex = 0;
          counter = 0;
        });
        positionController.reverse();
      } else if (positionController.isDismissed) {
        return true;
      }
    }
    return false;
  }
}

class TreesRow extends StatelessWidget {
  const TreesRow({
    super.key,
    required this.contentFontsize,
    required this.elementName,
    required this.widgetName,
    this.showWidget = false,
    this.showElement = false,
    this.layer = 0,
    this.showStateObject = false,
  });

  final double contentFontsize;
  final String widgetName;
  final String elementName;
  final bool showStateObject, showWidget, showElement;
  final int layer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (showWidget)
          Expanded(
            child: TreeItemWidget(
              content: widgetName,
              textStyle: kBasicTextStyle.copyWith(
                fontSize: contentFontsize,
              ),
              layer: layer,
              visible: true,
            ),
          ),
        if (showElement) ...[
          SizedBox(width: 12),
          Transform.rotate(
            angle: pi,
            child: CustomPaint(
              painter: _ArrowPainter(),
              child: SizedBox(
                width: contentFontsize * 2,
                height: contentFontsize,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: TreeItemWidget(
              content: elementName,
              textStyle: kBasicTextStyle.copyWith(
                fontSize: contentFontsize,
              ),
              layer: layer,
              visible: true,
            ),
          ),
        ] else
          Spacer(),
        if (showStateObject) ...[
          SizedBox(width: 12),
          Transform.rotate(
            angle: pi,
            child: CustomPaint(
              painter: _ArrowPainter(),
              child: SizedBox(
                width: contentFontsize * 2,
                height: contentFontsize,
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: Color.fromARGB(255, 47, 82, 143),
                width: contentFontsize / 14,
              ),
            ),
            constraints: BoxConstraints(
              maxWidth: 100,
              maxHeight: 100,
            ),
            child: Padding(
              padding: EdgeInsets.all(contentFontsize / 5),
              child: AutoSizeText(
                '$widgetName\nState',
                style: kBasicTextStyle.copyWith(fontSize: contentFontsize),
                maxLines: 2,
              ),
            ),
          ),
        ] else
          SizedBox(width: (contentFontsize * 2) + 124),
      ],
    );
  }
}

class _Sample extends StatelessWidget {
  const _Sample({
    Key? key,
    required this.featureContainerWidth,
    required this.counter,
    required this.floatingHeroTag,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final double featureContainerWidth;
  final int counter;
  final Object floatingHeroTag;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return MobileContainer(
      topChildConstraints: BoxConstraints(
        maxWidth: featureContainerWidth,
        minWidth: featureContainerWidth,
      ),
      alignment: alignment,
      topChild: Theme(
        data: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color(0xFF223044),
          appBarTheme: AppBarTheme(
            color: Color(0xFF152030),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Widget Tree'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'You\'ve tapped the button $counter times',
                style: kBasicTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            heroTag: null,
          ),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradientPaint = Paint()..color = Color(0xFF223044);

    final arrowPath = Path();

    final arrowLength = size.width / 4;
    final rectHeight = size.height / 4;
    final center = size.height / 2;

    arrowPath.moveTo(0, rectHeight);
    // Center top rect part
    arrowPath.lineTo(size.width - arrowLength, rectHeight);
    // right top arrow part
    arrowPath.lineTo(size.width - arrowLength, 0);
    arrowPath.lineTo(size.width, center);
    // right bottom arrow part
    arrowPath.lineTo(size.width - arrowLength, size.height);
    arrowPath.lineTo(size.width - arrowLength, size.height * (3 / 4));
    // Center bottom rect part
    arrowPath.lineTo(arrowLength, size.height * (3 / 4));
    // left bottom arrow part
    arrowPath.lineTo(0, size.height - rectHeight);

    arrowPath.close();

    canvas.drawPath(arrowPath, gradientPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
