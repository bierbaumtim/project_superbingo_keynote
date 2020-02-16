import 'package:flutter/cupertino.dart';
import 'package:project_keynote/slide.dart';

abstract class ISlideInteractionService {
  void registerSlideKey(GlobalKey<SlideState> slideKey);
  void setupDatabaseListener();
  void dispose();
  void startKeynote();
  GlobalKey<SlideState> currentSlideKey;
}
