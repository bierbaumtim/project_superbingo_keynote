import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slide_interaction_service.dart';

typedef OnKeyboardTap = bool Function(String action);

class KeyboardHandler extends StatefulWidget {
  final Widget child;
  final OnKeyboardTap onKeyboardTap;

  const KeyboardHandler({
    Key key,
    @required this.child,
    @required this.onKeyboardTap,
  }) : super(key: key);

  @override
  _KeyboardHandlerState createState() => _KeyboardHandlerState();
}

class _KeyboardHandlerState extends State<KeyboardHandler> {
  final _focusNode = FocusNode();
  Size windowSize;
  bool isFullscreen;

  @override
  void initState() {
    super.initState();
    isFullscreen = false;
    windowSize = Size(0, 0);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (event) {
        if (event is RawKeyUpEvent) {
          print(event.data.logicalKey);
          if (event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
            RepositoryProvider.of<SlideInteractionService>(context)
                .handleAction(kNextAction);
          } else if (event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
            RepositoryProvider.of<SlideInteractionService>(context)
                .handleAction(kPreviousAction);
          }
        }
      },
      child: Material(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
