import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final double sizeFactor;
  final String imageAssetsUrl;

  const ImageView({
    super.key,
    this.sizeFactor = 0.8,
    required this.imageAssetsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FractionallySizedBox(
          heightFactor: sizeFactor,
          child: Image.asset(
            imageAssetsUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
