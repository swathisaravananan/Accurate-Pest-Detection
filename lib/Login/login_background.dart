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
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 40,
            right: 10,
            child: Image.asset(
              "assets/pest2.png",
              width: size.width * 0.35,
            ),
          ),
         /* Positioned(
            bottom: 0,
            right: 10,
            child: Image.asset(
              "assets/pest2.png",
              width: size.width * 0.3,
            ),
          ),*/
          child,
        ],
      ),
    );
  }
}