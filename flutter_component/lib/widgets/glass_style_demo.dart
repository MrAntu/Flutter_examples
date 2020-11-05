import 'package:flutter/material.dart';
import 'dart:ui';

class GlassStyleDemo extends StatelessWidget {
  const GlassStyleDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
//          FractionallySizedBox(
//            widthFactor: 1,
//            heightFactor: 1,
//            child: FlutterLogo(),
//          ),
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: FlutterLogo(),
          ),

          /**
           * 使用BackdropFilter实现毛玻璃效果,且子部件需要设置Opacity
           * 使用这个部件的代价很高，尽量少用
           * ImageFilter.blur的sigmaX/Y决定了毛玻璃的模糊程度，值越高越模糊
           * 一般来说，为了防止模糊效果绘制出边界，需要使用ClipRect Widget包裹
           */
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 210,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200
                    ),
                    child: Center(
                      child:  Text(
                        'Frosted',
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
