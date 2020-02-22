import 'package:flutter/widgets.dart';

import 'blur_transition.dart';

class OverlayRoute<T> extends PageRoute<T> {
  OverlayRoute({
    @required this.builder,
    this.barrierLabel,
    this.backgroundColor = const Color(0xFF000000),
    this.backgroundOpacity = 0.25,
    this.blur = 4.5,
    RouteSettings settings,
  })  : assert(blur != null),
        assert(backgroundOpacity != null),
        assert(backgroundColor != null),
        super(
          settings: settings,
        );

  @override
  Color get barrierColor => const Color(0x00000001);

  @override
  bool get barrierDismissible => true;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  final String barrierLabel;

  final WidgetBuilder builder;

  final Color backgroundColor;

  final double backgroundOpacity;

  final double blur;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final child = builder(context);

    assert(() {
      if (child == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary(
              'The builder for route "${settings.name}" returned null.'),
          ErrorDescription('Route builders must never return null.')
        ]);
      }
      return true;
    }());

    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return BlurTransition(
      blurAnimation: Tween<double>(
        begin: 0,
        end: blur,
      ).animate(animation),
      backgroundColorAnimation: Tween<double>(
        begin: 0,
        end: backgroundOpacity,
      ).animate(animation),
      backgroundColor: backgroundColor,
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 355);
}
