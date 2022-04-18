import 'package:flutter/material.dart';
import 'package:Zenith/helper/color.dart';

class ProgressHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Offset? offset;
  final Widget progressIndicator;
  final bool dismissible;
  final Widget child;

  ProgressHUD({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.0,
    this.color = transparent,
    this.offset,
    this.progressIndicator = const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
    ),
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    Widget layOutProgressIndicator;
    if (offset == null)
      layOutProgressIndicator = Center(child: progressIndicator);
    else {
      layOutProgressIndicator = Positioned(
        child: progressIndicator,
        left: offset!.dx,
        top: offset!.dy,
      );
    }

    return new Stack(
      children: [
        child,
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator,
      ],
    );
  }
}
