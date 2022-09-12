import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:project_keynote/text_styles.dart';

class TreeItemWidget extends StatelessWidget {
  final String content;
  final int layer;
  final TextStyle? textStyle;
  final bool visible;

  const TreeItemWidget({
    super.key,
    required this.content,
    this.layer = 0,
    this.textStyle,
    this.visible = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTextStyle = textStyle ?? kBasicTextStyle;

    if (visible) {
      return PlayAnimationBuilder(
        duration: const Duration(milliseconds: 550),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, animtedValue, child) => Opacity(
          opacity: animtedValue,
          child: child!,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: effectiveTextStyle.fontSize! / 10,
              color: const Color.fromARGB(
                255,
                47,
                82,
                143,
              ),
              // color: Color(0xFF223044),
            ),
          ),
          padding: EdgeInsets.all(effectiveTextStyle.fontSize! / 6),
          margin: EdgeInsets.fromLTRB(
            layer * 20.0,
            effectiveTextStyle.fontSize! / 5,
            0,
            effectiveTextStyle.fontSize! / 5,
          ),
          constraints: BoxConstraints(
            minWidth: 300,
            minHeight:
                effectiveTextStyle.fontSize! * effectiveTextStyle.height!,
          ),
          child: Center(
            child: AutoSizeText(
              content,
              style: effectiveTextStyle,
              maxLines: 1,
              minFontSize: 6,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
