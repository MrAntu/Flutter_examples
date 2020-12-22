import 'package:flutter/material.dart';

class ScaleAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  const ScaleAnimatedSwitcher({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    return AnimatedSwitcher(
//      duration: Duration(microseconds: 300),
//      transitionBuilder: (child, animation) => ScaleTransition(
//        scale: animation,
//        child: child,
//      ),
//      child: child,
//    );

    return AnimatedSwitcher(
      duration: Duration(microseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class EmptyAnimatedSwitcher extends StatelessWidget {
  final bool display;
  final Widget child;
  const EmptyAnimatedSwitcher({Key key, this.child, this.display})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitcher(
      child: display ? child : SizedBox.shrink(),
    );
  }
}
