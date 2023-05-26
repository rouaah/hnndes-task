import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size){
    Path path=Path();
    // path.moveTo(100, 100);
    path.lineTo(0, size.height/2);
    path.quadraticBezierTo(size.width/4, size.height*1.3, size.width, size.height/2);
    // path.
    path.lineTo(size.width, 0);
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return true;
  }
}
