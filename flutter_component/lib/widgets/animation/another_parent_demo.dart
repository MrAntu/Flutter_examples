import 'package:flutter/material.dart';

class AnotherParentDemo extends StatefulWidget {
  const AnotherParentDemo({Key key}) : super(key: key);

  @override
  _AnotherParentDemoState createState() => _AnotherParentDemoState();
}

class _AnotherParentDemoState extends State<AnotherParentDemo> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation parentAnimation;
  Animation childAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    parentAnimation = Tween(begin: -0.5, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
      )
    );

    childAnimation = Tween(begin: 0.0, end: 100.0).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Curves.easeIn
        )
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: parentAnimation,
        builder: (context, child) {
          return Scaffold(
            body: Transform(
              transform: Matrix4.translationValues(parentAnimation.value * width, 0, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                        animation: childAnimation,
                        builder: (context, child) {
                          return Container(
                            color: Colors.lightBlue,
                            width: childAnimation.value * 2.0,
                            height: childAnimation.value,
                          );
                        }),
                    Container(
                      color: Colors.orange,
                      width: 200,
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }


}
