import 'package:flutter/services.dart';

import 'package:project_keynote/slide.dart';
import 'package:project_keynote/text_styles.dart';
import 'package:project_keynote/widgets/keyboard_handler.dart';

const kPublicGamesHeroTag = 'publicgamestag';
const kGameHeroTag = 'gametag';
const kPlayerHeroTag = 'playertag';
const kGameConfigHeroTag = 'gameconfigtag';

class SuperBingoSlide extends StatefulWidget {
  const SuperBingoSlide({super.key});

  @override
  SlideState<SuperBingoSlide> createState() => _SuperBingoSlideState();
}

class _SuperBingoSlideState extends SlideState<SuperBingoSlide> {
  late bool isOverlayActive;
  late int currentImageIndex;

  @override
  void initState() {
    super.initState();
    isOverlayActive = false;
    currentImageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => handleTap('next'),
      child: KeyboardHandler(
        onKeyboardTap: handleTap,
        child: Material(
          color: kSlideBackground,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final titleFontsize =
                  calculateTitleFontsize(constraints.maxWidth);

              return Padding(
                padding: const EdgeInsets.all(1.5 * kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    DefaultTextStyle(
                      style: kBasicTextStyle.copyWith(
                        fontSize: titleFontsize,
                      ),
                      child: const Text('UI'),
                    ),
                    const SizedBox(height: kToolbarHeight),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Hero(
                            tag: kPlayerHeroTag,
                            child: Image.asset(
                              'assets/iphone_x_player_page.png',
                            ),
                          ),
                          Hero(
                            tag: kGameConfigHeroTag,
                            child: Image.asset(
                              'assets/iphone_x_game_config_page.png',
                            ),
                          ),
                          Hero(
                            tag: kPublicGamesHeroTag,
                            child: Image.asset(
                              'assets/iphone_x_public_games_page.png',
                            ),
                          ),
                          Hero(
                            tag: kGameHeroTag,
                            child: Image.asset(
                              'assets/iphone_x_game_page.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool handleTap(String action) {
    if (action == kNextAction) {
      // if (currentImageIndex <= 4) {
      //   if (!isOverlayActive) {
      //     final heroTag = indexToHeroTag(currentImageIndex);
      //     final url = indexToAssetUrl(currentImageIndex);
      //     if (heroTag != null && url != null) {
      //       setState(() {
      //         isOverlayActive = true;
      //       });
      //       Navigator.of(context)
      //           .push(
      //         ov.OverlayRoute(
      //           builder: (context) => _ImageOverlay(
      //             tag: heroTag,
      //             assetUrl: url,
      //           ),
      //         ),
      //       )
      //           .then(
      //         (value) {
      //           if (currentImageIndex < 4) {
      //             setState(() {
      //               currentImageIndex++;
      //               isOverlayActive = false;
      //             });
      //           }
      //         },
      //       );
      //       return false;
      //     }
      //   }
      //   return false;
      // } else {
      //   return true;
      // }
    } else if (action == kPreviousAction) {}
    return true;
  }

  Object? indexToHeroTag(int index) {
    switch (index) {
      case 0:
        return kPlayerHeroTag;
      case 1:
        return kGameConfigHeroTag;
      case 2:
        return kPublicGamesHeroTag;
      case 3:
        return kGameHeroTag;
      default:
        return null;
    }
  }

  String? indexToAssetUrl(int index) {
    switch (index) {
      case 0:
        return 'assets/iphone_x_player_page.png';
      case 1:
        return 'assets/iphone_x_game_config_page.png';
      case 2:
        return 'assets/iphone_x_public_games_page.png';
      case 3:
        return 'assets/iphone_x_game_page.png';
      default:
        return null;
    }
  }
}

class _ImageOverlay extends StatefulWidget {
  final Object tag;
  final String assetUrl;

  const _ImageOverlay({
    Key? key,
    required this.tag,
    required this.assetUrl,
  }) : super(key: key);

  @override
  __ImageOverlayState createState() => __ImageOverlayState();
}

class __ImageOverlayState extends State<_ImageOverlay> {
  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      onKey: (event) {
        if (event is RawKeyUpEvent) {
          Navigator.of(context).pop();
        }
      },
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.all(kToolbarHeight),
          child: Hero(
            tag: widget.tag,
            child: Image.asset(widget.assetUrl),
          ),
        ),
      ),
    );
  }
}
