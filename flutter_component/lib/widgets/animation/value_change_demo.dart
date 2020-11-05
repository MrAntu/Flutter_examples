import 'package:flutter/material.dart';

class ValueChangeAnimationDemo extends StatefulWidget {
  const ValueChangeAnimationDemo({Key key}) : super(key: key);

  @override
  _ValueChangeAnimationDemoState createState() => _ValueChangeAnimationDemoState();
}

class _ValueChangeAnimationDemoState extends State<ValueChangeAnimationDemo> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = IntTween(
      begin: 5,
      end: 0
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.ease
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
    final double textSize = 56.0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('waiting ....',
              style: TextStyle(
                fontSize: textSize
              ),
            ),
            AnimatedBuilder(animation: animationController,
                builder: (context, child) {
                  return Text(animation.value.toString(), style: TextStyle(
                    fontSize: textSize
                  ),);
                }
            )
          ],
        ),
      ),
    );
  }
}
