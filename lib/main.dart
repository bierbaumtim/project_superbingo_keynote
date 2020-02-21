import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_keynote/flutter_keynote.dart';
import 'keys.dart';
import 'slide.dart';
import 'slide_interaction_service.dart';
import 'slides/flutter/flutter_cross_platform_layer_slide.dart';
import 'slides/flutter/flutter_widget_tree_slide.dart';
import 'slides/intro_slide.dart';
import 'slides/flutter/flutter_intro_slide.dart';
import 'slides/flutter/everything_is_a_widget_slide.dart';
import 'slides/flutter/stateless_vs_stateful_slide.dart';
import 'slides/flutter/flutter_cross_platform_slide.dart';
import 'slides/flutter/pub_dev_slide.dart';
import 'slides/superbingo/superbingo_intro_slide.dart';
import 'slides/superbingo/idee_slide.dart';
import 'slides/superbingo/ziele_slide.dart';
import 'slides/superbingo/herausforderungen_slide.dart';
import 'text_styles.dart';

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
  interactionService.registerSlideKey(kFlutterWidgetTreeSlideKey);
  interactionService.registerSlideKey(kFlutterCrossPlatformSlideKey);
  interactionService.registerSlideKey(kFlutterCrossPlatformLayerSlideKey);
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
    return Container(
      color: kSlideBackground,
      constraints: BoxConstraints(
        maxHeight: 1080,
        maxWidth: 1920,
      ),
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: KeynoteApp(
          slides: <Widget>[
            IntroSlide(key: kIntroSlideKey),
            FlutterIntroSlide(key: kFlutterIntroSlideKey),
            EverythingIsAWidgetSlide(key: kEverythingIsAWidgetSlideKey),
            StatelessVSStafulSlide(key: kStatelessVSStatefulSlideKey),
            FlutterWidgetTreeSlide(key: kFlutterWidgetTreeSlideKey),
            FlutterCrossPlatformSlide(key: kFlutterCrossPlatformSlideKey),
            FlutterCrossPlatformLayerSlide(
              key: kFlutterCrossPlatformLayerSlideKey,
            ),
            PackagesSlide(key: kPubDevSlideKey),
            SuperbingoIntroSlide(key: kFSuperbingoIntroSlideKey),
            IdeeSlide(key: kIdeeSlideKey),
            HerausforderungenSlide(key: kHerausforderungenSlideKey),
            ZielSlide(key: kZielSlideKey),
          ],
          swipeGesture: true,
          handleKeyboardInputs: false,
          transition: KeynoteTransition.fade,
          theme: ThemeData.dark().copyWith(
            textTheme: kBasicTextTheme,
          ),
          title: 'Flutter',
          darkTheme: ThemeData.dark().copyWith(
            textTheme: kBasicTextTheme,
          ),
          keynoteProvider:
              RepositoryProvider.of<SlideInteractionService>(context)
                  .keynoteProvider,
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
