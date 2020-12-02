import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _appBar(context),
    );
  }

  Widget _appBar(BuildContext context) {
    print(MediaQuery.of(context).padding.bottom);
    var safeTop = MediaQuery.of(context).padding.top;
    return Container(
        color: Colors.red,
        height: 100,
        child: Column(
          children: [
            SizedBox(
              height: safeTop,
            ),
            SizedBox(
              height: 100 - safeTop,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: IconButton(
                      icon: new Icon(
                        defaultTargetPlatform == TargetPlatform.android
                            ? Icons.arrow_back
                            : Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : null,
                    ),
                  ),
                  new Text(
                    "Product Detail",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  new Opacity(
                    opacity: 1,
                    child: new IconButton(
                      icon: new Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
