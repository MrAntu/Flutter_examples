import 'package:flutter/material.dart';


class AnimationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimationDemo"),),
      body: AnimationDemoHome(),
    );
  }
}

class AnimationDemoHome extends StatefulWidget {
  @override
  _AnimationDemoHomeState createState() => _AnimationDemoHomeState();
}

class _AnimationDemoHomeState extends State<AnimationDemoHome> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation _animation;
  Animation _colorAnimation;
  CurvedAnimation _curved;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
//      lowerBound: 30,
//      upperBound: 100,
//      value: 30,
      vsync: this,
    );

    // curved
    _curved = CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);

    // Tween设置范围
    _animation = Tween(begin: 32.0, end: 100.0).animate(_curved);
    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.red[900]).animate(_curved);

//    _animationController.addListener(() {
//      //刷新ui
//      setState(() {
//
//      });
//    });

    _animationController.addStatusListener((status) {
      print("${status}");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedHeart(
        controller: _animationController,
        animations: [_animation, _colorAnimation],
      )
    );
  }
}

class AnimatedHeart extends AnimatedWidget {
  final List animations;
  final AnimationController controller;

  AnimatedHeart({
    this.animations,
    this.controller
  }) : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
        icon: Icon(Icons.favorite),
        iconSize: animations[0].value,
        color: animations[1].value,
        onPressed: () {
          switch (controller.status) {
            case AnimationStatus.completed:
              controller.reverse();
              break;
            default:
            //开启动画
              controller.forward();
          }
        }
    );
  }
}
