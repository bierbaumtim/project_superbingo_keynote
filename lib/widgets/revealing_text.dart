import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

class RevealingText extends StatefulWidget {
  final List<Text> parts;
  final int lastVisiblePart;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAligment;
  final bool reverse;
  final Map<int, int> partsLayer;

  const RevealingText({
    Key key,
    this.parts = const <Text>[],
    this.lastVisiblePart = -1,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAligment = MainAxisAlignment.center,
    this.reverse = false,
    this.partsLayer = const <int, int>{},
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
          final layer = widget.partsLayer.containsKey(index)
              ? widget.partsLayer[index]
              : 0;

          if (widget.reverse) {
            if (index <= widget.lastVisiblePart) {
              return buildStaticPart(part, layer);
            }
          } else {
            if (index < widget.lastVisiblePart) {
              return buildStaticPart(part, layer);
            } else if (index == widget.lastVisiblePart) {
              return buildAnimatedPart(part, layer);
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

  String buildLayer(int layer) {
    final blanks = List.generate(
      layer * 2,
      (_) => ' ',
    );

    return blanks.join();
  }

  Widget buildStaticPart(Text part, [int layer = 0]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${buildLayer(layer)}• ',
            style: part.style,
          ),
          Expanded(
            child: part,
          ),
        ],
      ),
    );
  }

  Widget buildAnimatedPart(Text part, [int layer = 0]) {
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
                '${buildLayer(layer)}• ',
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
