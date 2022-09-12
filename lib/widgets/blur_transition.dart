import 'dart:ui';

import 'package:flutter/widgets.dart';

class BlurTransition extends AnimatedWidget {
  final Widget child;
  final Animation<double> blurAnimation;
  final Animation<double>? backgroundColorAnimation;
  final Color? backgroundColor;

  const BlurTransition({
    required this.blurAnimation,
    required this.child,
    this.backgroundColorAnimation,
    this.backgroundColor,
  }) : super(listenable: blurAnimation);

  @override
  Widget build(BuildContext context) {
    Color? color;
    if (backgroundColorAnimation != null && backgroundColor != null) {
      color = backgroundColor!.withOpacity(backgroundColorAnimation!.value);
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurAnimation.value,
        sigmaY: blurAnimation.value,
      ),
      child: Container(
        color: color,
        child: child,
      ),
    );
  }
}
