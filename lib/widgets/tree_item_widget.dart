import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';

import 'package:project_keynote/text_styles.dart';

class TreeItemWidget extends StatelessWidget {
  final String content;
  final int layer;
  final TextStyle textStyle;
  final bool visible;

  const TreeItemWidget({
    Key key,
    @required this.content,
    this.layer = 0,
    this.textStyle,
    this.visible = false,
  })  : assert(content != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return ControlledAnimation(
        duration: const Duration(milliseconds: 550),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, animtedValue) => Opacity(
          opacity: animtedValue,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: textStyle.fontSize / 10,
                color: Color.fromARGB(
                  255,
                  47,
                  82,
                  143,
                ),
                // color: Color(0xFF223044),
              ),
            ),
            child: Center(
              child: AutoSizeText(
                content,
                style: textStyle ?? kBasicTextStyle,
                maxLines: 1,
              ),
            ),
            padding: EdgeInsets.all(textStyle.fontSize / 6),
            margin: EdgeInsets.fromLTRB(
              layer * 20.0,
              textStyle.fontSize / 5,
              0,
              textStyle.fontSize / 5,
            ),
            constraints: BoxConstraints(
              minWidth: 300,
              minHeight: (textStyle ?? kBasicTextStyle).fontSize *
                  (textStyle ?? kBasicTextStyle).height,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
