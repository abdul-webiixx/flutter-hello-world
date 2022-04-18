import 'package:flutter/cupertino.dart';

class BottomClipper extends CustomClipper<Path> {
  var roundnessFactor = 15.0;
  @override
  Path getClip(Size size) {
    Path path = new Path();

    var gap = 20;
    var width = size.width;
    var height = size.height;
    var bottomLeftControlPoint = Offset(0.0, height);
    var bottomLeftEndPoint = Offset(roundnessFactor, height);

    var bottomRightControlPoint = Offset(width, height);
    var bottomRightEndPoint = Offset(width, height - roundnessFactor);

    var topRightControlPoint = Offset(width, 20);
    var topRightEndPoint = Offset(width - roundnessFactor, 20);

    var topLeftControlPoint = Offset(0, 20);
    var topLeftEndPoint = Offset(0, roundnessFactor + gap);

    path.moveTo(0, roundnessFactor + gap);

    path.lineTo(0, height - roundnessFactor);

    path.quadraticBezierTo(bottomLeftControlPoint.dx, bottomLeftControlPoint.dy,
        bottomLeftEndPoint.dx, bottomLeftEndPoint.dy);

    path.lineTo(width - roundnessFactor, height);

    path.quadraticBezierTo(
        bottomRightControlPoint.dx,
        bottomRightControlPoint.dy,
        bottomRightEndPoint.dx,
        bottomRightEndPoint.dy);

    path.lineTo(width, roundnessFactor + gap);
    path.quadraticBezierTo(topRightControlPoint.dx, topRightControlPoint.dy,
        topRightEndPoint.dx, topRightEndPoint.dy);

    path.lineTo(width / 2 + 10, 5);

    path.lineTo(width / 2 - 10, 5);
    path.lineTo(roundnessFactor, 20);

    path.quadraticBezierTo(topLeftControlPoint.dx, topLeftControlPoint.dy,
        topLeftEndPoint.dx, topLeftEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
