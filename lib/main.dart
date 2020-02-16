import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_keynote/flutter_keynote.dart';
import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slide_interaction_service.dart';
import 'package:project_keynote/slides/flutter/flutter_intro_slide.dart';
import 'package:project_keynote/slides/superbingo/herausforderungen_slide.dart';
import 'package:project_keynote/slides/superbingo/idee_slide.dart';
import 'package:project_keynote/slides/superbingo/superbingo_intro_slide.dart';
import 'package:project_keynote/text_styles.dart';

import 'keys.dart';
import 'slides/flutter/everything_is_a_widget_slide.dart';
import 'slides/flutter/flutter_cross_platform_slide.dart';
import 'slides/flutter/pub_dev_slide.dart';
import 'slides/flutter/stateless_vs_stateful_slide.dart';
import 'slides/intro_slide.dart';
import 'slides/superbingo/ziele_slide.dart';

void main() {
  if (!kIsWeb) {
    if (!(io.Platform.isAndroid || io.Platform.isIOS)) {
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
    }
  }

  final interactionService = SlideInteractionService();
  interactionService.registerSlideKey(kIntroSlideKey);
  // Flutter
  interactionService.registerSlideKey(kFlutterIntroSlideKey);
  interactionService.registerSlideKey(kEverythingIsAWidgetSlideKey);
  interactionService.registerSlideKey(kStatelessVSStatefulSlideKey);
  interactionService.registerSlideKey(kFlutterCrossPlatformSlideKey);
  interactionService.registerSlideKey(kPubDevSlideKey);
  // Superbingo
  interactionService.registerSlideKey(kFSuperbingoIntroSlideKey);
  interactionService.registerSlideKey(kIdeeSlideKey);
  interactionService.registerSlideKey(kHerausforderungenSlideKey);
  interactionService.registerSlideKey(kZielSlideKey);

  interactionService.startKeynote();

  runApp(
    RepositoryProvider<SlideInteractionService>(
      create: (context) => interactionService,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeynoteApp(
      slides: <Widget>[
        IntroSlide(key: kIntroSlideKey),
        FlutterIntroSlide(key: kFlutterIntroSlideKey),
        EverythingIsAWidgetSlide(key: kEverythingIsAWidgetSlideKey),
        StatelessVSStafulSlide(key: kStatelessVSStatefulSlideKey),
        FlutterCrossPlatformSlide(key: kFlutterCrossPlatformSlideKey),
        PackagesSlide(key: kPubDevSlideKey),
        SuperbingoIntroSlide(key: kFSuperbingoIntroSlideKey),
        IdeeSlide(key: kIdeeSlideKey),
        HerausforderungenSlide(key: kHerausforderungenSlideKey),
        ZielSlide(key: kZielSlideKey),
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
      keynoteProvider: RepositoryProvider.of<SlideInteractionService>(context)
          .keynoteProvider,
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
