import 'package:flutter/material.dart';

class ChromeMockupContainer extends StatelessWidget {
  final Widget child;
  final double sizeFactor;
  final String imageAssetsUrl;

  const ChromeMockupContainer({
    super.key,
    required this.child,
    required this.imageAssetsUrl,
    this.sizeFactor = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: sizeFactor,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            // SvgPicture.asset(
            //   'assets/chrome_mockup_dark.svg',
            //   semanticsLabel: 'Chrome Mockup Dark',
            // ),

            Image.asset(
              imageAssetsUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              top: 90,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
