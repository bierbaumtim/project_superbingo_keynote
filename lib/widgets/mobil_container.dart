import 'package:flutter/material.dart';

class MobileContainer extends StatelessWidget {
  final Widget topChild;
  final Widget backChild;
  final BoxConstraints topChildConstraints;
  final Alignment alignment;

  const MobileContainer({
    Key key,
    this.topChild,
    this.backChild,
    this.topChildConstraints,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (backChild != null) backChild,
        Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF223044),
              borderRadius: BorderRadius.circular(40),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[850],
                  blurRadius: 10,
                ),
              ],
            ),
            constraints: topChildConstraints,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: topChild,
            ),
            margin: const EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
