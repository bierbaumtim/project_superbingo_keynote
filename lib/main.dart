import 'dart:io' as io;
import 'dart:math' if (kIsWeb) 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keynote/flutter_keynote.dart';
import 'package:simple_animations/simple_animations.dart';

const kBasicTextStyle = TextStyle(
  fontFamily: 'Consolas',
  fontSize: 35,
  color: Colors.black,
  height: 1.1288,
);

const kBasicTextTheme = TextTheme(
  body1: kBasicTextStyle,
  body2: kBasicTextStyle,
);

const kSlideBackground = Color.fromARGB(255, 236, 236, 236);

void main() {
  if (!kIsWeb) {
    if (!(io.Platform.isAndroid || io.Platform.isIOS)) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KeynoteApp(
      slides: <Widget>[
        FirstSlide(),
        SecondSlide(),
        PackagesSlide(),
        Container(
          color: kSlideBackground,
          height: double.infinity,
          width: double.infinity,
        ),
      ],
      swipeGesture: true,
      transition: KeynoteTransition.fade,
      theme: ThemeData.dark().copyWith(
        textTheme: kBasicTextTheme,
      ),
      title: 'Flutter',
      darkTheme: ThemeData.dark().copyWith(
        textTheme: kBasicTextTheme,
      ),
    );
  }
}

class PackagesSlide extends StatefulWidget {
  const PackagesSlide({
    Key key,
  }) : super(key: key);

  @override
  _PackagesSlideState createState() => _PackagesSlideState();
}

class _PackagesSlideState extends State<PackagesSlide>
    with TickerProviderStateMixin {
  AnimationController sizeController, positionController;
  Animation<double> sizeFactor, xPosition;
  bool showText;
  int lastVisiblePart;

  @override
  void initState() {
    super.initState();
    showText = false;
    lastVisiblePart = -1;
    sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    positionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    sizeController.addListener(() {
      setState(() {});
    });
    sizeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        positionController.forward();
      }
    });
    positionController.addListener(() {
      setState(() {});
    });
    positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showText = true;
        });
      }
    });
    sizeFactor = Tween<double>(begin: 0.8, end: 0.5).animate(
      sizeController,
    );
    xPosition = Tween<double>(begin: 0, end: -.2).animate(
      positionController,
    );
  }

  @override
  void dispose() {
    sizeController.dispose();
    positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (sizeController.isCompleted && positionController.isCompleted) {
          if (lastVisiblePart < 3) {
            setState(() {
              lastVisiblePart += 1;
              print(lastVisiblePart);
            });
          }
        } else {
          sizeController.forward();
        }
      },
      child: Container(
        color: kSlideBackground,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            FractionalTranslation(
              translation: Offset(xPosition?.value ?? 0, 0),
              child: ChromeMockupContainer(
                // child: WebViewContainer(),
                sizeFactor: sizeFactor?.value ?? 0.8,
                child: Container(),
              ),
            ),
            if (showText)
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                bottom: kToolbarHeight,
                right: kToolbarHeight,
                child: Material(
                  color: Colors.transparent,
                  child: ControlledAnimation<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 750),
                    delay: const Duration(milliseconds: 250),
                    builder: (context, animation) => Opacity(
                      opacity: animation,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Center(
                          child: RevealingText(
                            lastVisiblePart: lastVisiblePart,
                            mainAxisAligment: MainAxisAlignment.start,
                            parts: <Text>[
                              Text(
                                'OpenSource Packages und Plugins',
                                style: theme.textTheme.body1.copyWith(
                                  fontSize: 45,
                                ),
                              ),
                              Text(
                                'Flutter Team & Community',
                                style: theme.textTheme.body1.copyWith(
                                  fontSize: 45,
                                ),
                              ),
                              Text(
                                'Constributing',
                                style: theme.textTheme.body1.copyWith(
                                  fontSize: 45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ChromeMockupContainer extends StatefulWidget {
  final Widget child;
  final double sizeFactor;

  const ChromeMockupContainer({
    Key key,
    @required this.child,
    this.sizeFactor = 0.8,
  }) : super(key: key);

  @override
  _ChromeMockupContainerState createState() => _ChromeMockupContainerState();
}

class _ChromeMockupContainerState extends State<ChromeMockupContainer> {
  @override
  void initState() {
    super.initState();
    // ignore: undefined_prefixed_name
    // ui.platformViewRegistry.registerViewFactory(
    //   'mockup',
    //   (int viewId) => ImageElement()..src = 'https://github.com/matthinc/flutter_cupertino_settings/blob/master/screenshots/scr1.png',
    //   // '../assets/chrome_mockup_dark.svg'
    // );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: FractionallySizedBox(
        heightFactor: widget.sizeFactor,
        widthFactor: widget.sizeFactor,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              // HtmlElementView(viewType: 'mockup'),
              // Image.asset('assets/chrome_mockup_dark.svg'),
              // SvgPicture.asset(
              //   'assets/chrome_mockup_dark.svg',
              //   semanticsLabel: 'Chrome Mockup Dark',
              // ),
              Image.asset(
                'assets/chrome_mockup_dark.png',
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                top: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  @override
  void initState() {
    super.initState();
    // ignore: undefined_prefixed_name
    // ui.platformViewRegistry.registerViewFactory(
    //   'webview',
    //   (int viewId) => IFrameElement()..src = 'https://pub.dev/',
    // );
  }

  @override
  Widget build(BuildContext context) {
    // return HtmlElementView(viewType: 'webview');
  }
}

class SecondSlide extends StatelessWidget {
  const SecondSlide({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kSlideBackground,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: 'flutter_logo',
          child: FlutterLogo(
            size: 120,
          ),
        ),
      ),
    );
  }
}

class FirstSlide extends StatelessWidget {
  const FirstSlide({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: <Color>[
      //       Colors.grey[600],
      //       Colors.grey[700],
      //       Colors.grey[800],
      //       Colors.grey[850],
      //       Colors.grey[900],
      //     ],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      // ),
      color: kSlideBackground,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'flutter_logo',
              child: FlutterLogo(),
            ),
            SizedBox(height: 48),
            Material(
              color: Colors.transparent,
              child: Text('Flutter'),
            ),
          ],
        ),
      ),
    );
  }
}

class RevealingText extends StatefulWidget {
  final List<Text> parts;
  final int lastVisiblePart;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAligment;

  const RevealingText({
    Key key,
    this.parts = const <Text>[],
    this.lastVisiblePart = -1,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAligment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  _RevealingTextState createState() => _RevealingTextState();
}

class _RevealingTextState extends State<RevealingText> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.body1;

    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisAlignment: widget.mainAxisAligment,
      children: widget.parts.map<Widget>((part) {
        final index = widget.parts.indexOf(part);
        if (index == -1 || widget.lastVisiblePart < 0) {
          return Container();
        } else {
          if (index < widget.lastVisiblePart) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' - ',
                    style: part.style,
                  ),
                  Expanded(
                    child: part,
                  ),
                ],
              ),
            );
          } else if (index == widget.lastVisiblePart) {
            return ControlledAnimation<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 550),
              delay: const Duration(milliseconds: 250),
              builder: (context, animation) => Opacity(
                opacity: animation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ' - ',
                        style: part.style,
                      ),
                      Expanded(
                        child: part,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              // height: 73,
              height: (part.style?.height ?? textStyle.height ?? 1.0) *
                  (part.style?.fontSize ?? textStyle.fontSize),
            );
          }
        }
      }).toList(),
    );
  }
}
