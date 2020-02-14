const kNextAction = 'next';
const kPreviousAction = 'previous';

abstract class ISlide {
  bool handleTap(String action);
}
