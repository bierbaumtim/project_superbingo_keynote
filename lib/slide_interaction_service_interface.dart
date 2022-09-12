import 'package:project_keynote/slide.dart';

abstract class ISlideInteractionService {
  void registerSlideKey(GlobalKey<SlideState> slideKey);
  void setupDatabaseListener();
  void dispose();
  void startKeynote();
  late GlobalKey<SlideState> currentSlideKey;
}
