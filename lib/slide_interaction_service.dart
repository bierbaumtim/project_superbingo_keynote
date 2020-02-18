import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keynote/flutter_keynote.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slide_interaction_service_interface.dart';

const kDBKeynoteDocumentPath = 'flutter-superbingo';

class SlideInteractionService implements ISlideInteractionService {
  List<GlobalKey<SlideState>> _slides;
  StreamSubscription _dbSub;
  KeynoteProvider _keynoteProvider;

  KeynoteProvider get keynoteProvider => _keynoteProvider;

  SlideInteractionService() {
    _slides = List<GlobalKey<SlideState>>();
  }

  @override
  GlobalKey<SlideState> currentSlideKey;

  @override
  void registerSlideKey(GlobalKey<SlideState> slideKey) {
    _slides.add(slideKey);
  }

  @override
  void setupDatabaseListener() {
    //   _dbSub = Firestore.instance
    //       .document(kDBKeynoteDocumentPath)
    //       .snapshots()
    //       .listen(handleSnapshot);
  }

  @override
  void startKeynote() {
    _keynoteProvider = KeynoteProvider(maxLength: _slides.length);
  }

  // void handleSnapshot(DocumentSnapshot document) {
  //   final json = document.data;
  //   var key = _slides
  //       .firstWhere((slide) => slide.toString() == json['current_slide']);
  //   if (key == null || key.currentState is! SlideState) {
  //     throw UnsupportedError('Key did not found.');
  //   } else {
  //     handleAction(json['action'], key);
  //   }
  // }

  void handleAction(String action, [GlobalKey<SlideState> slideKey]) {
    final key = slideKey ?? _slides.elementAt(_keynoteProvider.getPageIndex());
    if (key == null) {
      print('Key Error');
      return;
    }
    print('CurrentState: ${key.currentState}');
    final result = key.currentState?.handleTap(action) ?? false;
    if (result) {
      final index = _slides.indexOf(key);
      if (action == kNextAction) {
        if (index + 1 < _slides.length - 1) {
          keynoteProvider.nextPage(key.currentContext);
          // final cKey = _slides.elementAt(index);

          // Firestore.instance.document(kDBKeynoteDocumentPath).updateData(
          //   <String, dynamic>{
          //     'next_slide': '',
          //     'current_slide': cKey.toString(),
          //     'action': "",
          //   },
          // );
        }
      } else if (action == kPreviousAction) {
        if (index - 1 >= 0) {
          keynoteProvider.previousPage(key.currentContext);
          // final cKey = _slides.elementAt(index);

          // Firestore.instance.document(kDBKeynoteDocumentPath).updateData(
          //   <String, dynamic>{
          //     'next_slide': '',
          //     'current_slide': cKey.toString(),
          //     'action': "",
          //   },
          // );
        }
      }
    }
  }

  @override
  void dispose() {
    _dbSub.cancel();
  }
}
