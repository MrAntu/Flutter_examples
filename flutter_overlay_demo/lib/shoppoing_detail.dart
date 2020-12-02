import 'package:flutter/material.dart';

class ShoppingDetail extends StatefulWidget {
  ShoppingDetail({Key key}) : super(key: key);

  @override
  _ShoppingDetailState createState() => _ShoppingDetailState();
}

class _ShoppingDetailState extends State<ShoppingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [DatailBackground(), ShoppingWidget()],
      ),
    );
  }
}

class ShoppingWidget extends StatelessWidget {
  const ShoppingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: deviceSize.height / 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              elevation: 2,
              child: Container(
                color: Colors.green,
                height: 40,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Card(
                elevation: 2,
                child: Container(
                  color: Colors.yellow,
                  height: 1200,
                ),
              ))
        ],
      ),
    );
  }
}

class DatailBackground extends StatelessWidget {
  const DatailBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_topHalf(context), bottomHalf],
    );
  }

  Widget _topHalf(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ClipPath(
        clipper: ArcClipper(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.network(
                "https://mosaic02.ztat.net/vgs/media/pdp-zoom/LE/22/1D/02/2A/12/LE221D022-A12@16.1.jpg",
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}

final bottomHalf = Flexible(
  flex: 3,
  child: Container(),
);

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);
    var secondControlPoint =
        new Offset(size.width - (size.width / 4), size.height);
    var secondPoint = new Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
