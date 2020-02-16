import 'package:flutter/widgets.dart';
export 'package:flutter/material.dart';

const kNextAction = 'next';
const kPreviousAction = 'previous';

abstract class ISlide {
  bool handleTap(String action);
}

abstract class Slide extends StatefulWidget {
  const Slide({Key key}) : super(key: key);
}

abstract class SlideState<T extends StatefulWidget> extends State<T>
    implements ISlide {}

const kSlideBackground = Color.fromARGB(255, 236, 236, 236);
