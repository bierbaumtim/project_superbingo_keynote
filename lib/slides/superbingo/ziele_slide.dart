import 'package:flutter/material.dart';

import 'package:project_keynote/slides/templates/simple_title_content.dart';

class ZielSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TitleContentSlide(
      title: Text('Ziel'),
      content: <Text>[
        Text('Erste Version'),
        Text('Grundlegende Funktionen'),
        Text('Wenige bis keine Animationen'),
        Text('Layout für Mobile'),
      ],
      contentMainAxisAligment: MainAxisAlignment.start,
      titleAlignment: CrossAxisAlignment.start,
    );
  }
}
