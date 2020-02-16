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
  final FocusNode _focusNode = FocusNode();

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
          LogicalKeyboardKey logicalKey;
          bool mapCharsToArrows = false;

          if (event.data.runtimeType == RawKeyEventDataWeb) {
            final data = event.data as RawKeyEventDataWeb;
            logicalKey = data.logicalKey;
          } else if (event.data.runtimeType == RawKeyEventDataFuchsia) {
            final data = event.data as RawKeyEventDataFuchsia;
            logicalKey = data.logicalKey;
          } else if (event.data.runtimeType == RawKeyEventDataLinux) {
            final data = event.data as RawKeyEventDataFuchsia;
            logicalKey = data.logicalKey;
          } else if (event.data.runtimeType == RawKeyEventDataAndroid) {
            final data = event.data as RawKeyEventDataAndroid;
            logicalKey = data.logicalKey;
            mapCharsToArrows = true;
          }

          if (logicalKey != null) {
            if (logicalKey == LogicalKeyboardKey.arrowRight ||
                (mapCharsToArrows && logicalKey == LogicalKeyboardKey.keyK)) {
              RepositoryProvider.of<SlideInteractionService>(context)
                  .handleAction(kNextAction);
            } else if (logicalKey == LogicalKeyboardKey.arrowLeft ||
                (mapCharsToArrows && logicalKey == LogicalKeyboardKey.keyI)) {
              RepositoryProvider.of<SlideInteractionService>(context)
                  .handleAction(kPreviousAction);
            }
          }
        }
      },
      child: widget.child,
    );
  }
}
