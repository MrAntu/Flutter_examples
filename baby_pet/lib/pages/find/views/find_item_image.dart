import 'package:flutter/material.dart';
import '../../../exports.dart';

class FindItemImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double radius;
  final GestureTapCallback onPress;
  FindItemImage(
      {Key key,
      @required this.imageUrl,
      this.width,
      this.height,
      this.radius = 5,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Hero(
        tag: UniqueKey(),
        child: ExtendCachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          corner: radius,
        ),
      ),
    );
  }
}
