import 'package:flutter/material.dart';

class TransformAnimationDemo extends StatefulWidget {
  const TransformAnimationDemo({Key key}) : super(key: key);

  @override
  _TransformAnimationDemoState createState() => _TransformAnimationDemoState();
}

class _TransformAnimationDemoState extends State<TransformAnimationDemo> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = BorderRadiusTween(
      begin: BorderRadius.circular(0),
      end: BorderRadius.circular(120)
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease
    ));

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

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: animation.value,
                  color: Colors.blue
                ),
                width: 200,
                height: 200,
                child: Text(animation.value.toString()),
              ),
            );
          },
        ),
      ),
    );
  }


}
