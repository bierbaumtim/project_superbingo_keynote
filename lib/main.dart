import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keynote/flutter_keynote.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slides/flutter/flutter_intro_slide.dart';
import 'package:project_keynote/slides/superbingo/herausforderungen_slide.dart';
import 'package:project_keynote/slides/superbingo/idee_slide.dart';
import 'package:project_keynote/slides/superbingo/superbingo_intro_slide.dart';
import 'package:project_keynote/text_styles.dart';

import 'slides/flutter/pub_dev_slide.dart';
import 'slides/intro_slide.dart';
import 'slides/superbingo/ziele_slide.dart';

void main() {
  if (!kIsWeb) {
    if (!(io.Platform.isAndroid || io.Platform.isIOS)) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeynoteApp(
      slides: <Widget>[
        IntroSlide(),
        FlutterIntroSlide(),
        FirstSlide(),
        SecondSlide(),
        PackagesSlide(),
        SuperbingoIntroSlide(),
        IdeeSlide(),
        HerausforderungenSlide(),
        ZielSlide(),
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
      keynoteProvider: KeynoteProvider(maxLength: 10),
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
