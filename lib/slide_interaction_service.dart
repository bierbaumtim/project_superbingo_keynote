import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/slide_interaction_service_interface.dart';

const kDBKeynoteDocumentPath = 'flutter-superbingo';

class SlideInteractionService implements ISlideInteractionService {
  List<GlobalKey<SlideState>> _slides;
  StreamSubscription _dbSub;

  @override
  GlobalKey<SlideState> currentSlideKey;

  @override
  void registerSlideKey(GlobalKey<SlideState> slideKey) {
    _slides.add(slideKey);
  }

  @override
  void setupDatabaseListener() {
    _dbSub = Firestore.instance
        .document(kDBKeynoteDocumentPath)
        .snapshots()
        .listen(handleAction);
  }

  void handleAction(DocumentSnapshot document) {
    final json = document.data;
    var key = _slides
        .firstWhere((slide) => slide.toString() == json['current_slide']);
    if (key == null || key.currentState is! SlideState) {
      throw UnsupportedError('Key did not found.');
    } else {
      final result = key.currentState.handleTap(json['action']);
      if (result) {
        var index = _slides.indexOf(key);
        if (index + 1 < _slides.length - 1) {
          index++;
          final cKey = _slides.elementAt(index);

          Firestore.instance.document(kDBKeynoteDocumentPath).updateData(
            <String, dynamic>{
              'next_slide': '',
              'current_slide': cKey.toString(),
              'action': "",
            },
          );
        }
      }
    }
  }

  @override
  void dispose() {}
}
