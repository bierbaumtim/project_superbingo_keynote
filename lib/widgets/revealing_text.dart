import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

class RevealingText extends StatefulWidget {
  final List<Text> parts;
  final int lastVisiblePart;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAligment;
  final bool reverse;

  const RevealingText({
    Key key,
    this.parts = const <Text>[],
    this.lastVisiblePart = -1,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAligment = MainAxisAlignment.center,
    this.reverse = false,
  }) : super(key: key);

  @override
  _RevealingTextState createState() => _RevealingTextState();
}

class _RevealingTextState extends State<RevealingText> {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Column(
      crossAxisAlignment: widget.crossAxisAlignment,
      mainAxisAlignment: widget.mainAxisAligment,
      children: widget.parts.map<Widget>((part) {
        final index = widget.parts.indexOf(part);
        if (index == -1 || widget.lastVisiblePart < 0) {
          return Container();
        } else {
          if (widget.reverse) {
            if (index <= widget.lastVisiblePart) {
              return buildStaticPart(part);
            }
          } else {
            if (index < widget.lastVisiblePart) {
              return buildStaticPart(part);
            } else if (index == widget.lastVisiblePart) {
              return buildAnimatedPart(part);
            }
          }
          return Container(
            height: (part.style?.height ?? textStyle.height ?? 1.0) *
                (part.style?.fontSize ?? textStyle.fontSize),
          );
        }
      }).toList(),
    );
  }

  Widget buildStaticPart(Text part) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '• ',
            style: part.style,
          ),
          Expanded(
            child: part,
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedPart(Text part) {
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
                '• ',
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
  }
}
