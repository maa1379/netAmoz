import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavHelper {
  static push(BuildContext context, Widget child,[Widget childCurrent]) {
    Navigator.push(
      context,
      PageTransition(
        type: childCurrent is Widget ? PageTransitionType.topToBottom : PageTransitionType.topToBottom,
        child: child,
        childCurrent: childCurrent,
      ),
    );
  }

  static pushR(BuildContext context, Widget child,[Widget childCurrent]) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: childCurrent is Widget ? PageTransitionType.rightToLeftWithFade : PageTransitionType.fade,
        child: child,
        childCurrent: childCurrent,
      ),
    );
  }
}
