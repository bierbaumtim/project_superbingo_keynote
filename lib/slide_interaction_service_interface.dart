import 'package:flutter/cupertino.dart';
import 'package:project_keynote/main.dart';

abstract class ISlideInteractionService {
  void registerSlideKey(GlobalKey<SlideState> slideKey);
  void setupDatabaseListener();
  void dispose();
  GlobalKey<SlideState> currentSlideKey;
}
