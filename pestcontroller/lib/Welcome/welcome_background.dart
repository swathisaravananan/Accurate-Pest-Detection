import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 40,
            left: 0,
            child: Image.asset(
              "assets/pest1.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Image.asset(
              "assets/pest2.png",
              width: size.width * 0.3,
            ),
          ),
          child,
        ],
      ),
    );
  }
}