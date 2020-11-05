import 'package:flutter/material.dart';

class HiddenWidgeDemo extends StatefulWidget {
  const HiddenWidgeDemo({Key key}) : super(key: key);

  @override
  _HiddenWidgeDemoState createState() => _HiddenWidgeDemoState();
}

class _HiddenWidgeDemoState extends State<HiddenWidgeDemo> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween(
      begin: 0.0,
      end: -0.15,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn
    ));
//    animationController.forward();
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
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Center(
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RaisedButton(
                        onPressed: (){},
                        child: Text('bug'),
                        elevation: 7,
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                      SizedBox(width: 10,),
                      RaisedButton(onPressed: (){},
                        child: Text('Details'),
                        elevation: 7,
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ],

                  ),
                ),

                GestureDetector(
                  onTap: () {
                    animationController.forward();
                  },
                  onDoubleTap: () {
                    animationController.reverse();

                  },
                  child: Center(
                    child: Container(
                      color: Colors.lightBlue,
                      width: 200,
                      height: 80,
                      transform: Matrix4.translationValues(0, animation.value * width, 0),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
