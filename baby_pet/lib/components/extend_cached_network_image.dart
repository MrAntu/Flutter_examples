import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/utils.dart';

class ExtendCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double corner;
  final String erroAssetName;
  VoidCallback onTap;
  ExtendCachedNetworkImage({
    Key key,
    this.imageUrl,
    this.width,
    this.height,
    this.corner,
    this.erroAssetName = 'find_empty_img',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: corner != null
            ? BorderRadius.all(Radius.circular(corner))
            : BorderRadius.zero,
        child: CachedNetworkImage(
          height: height,
          width: width,
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          errorWidget: (context, url, error) =>
              Image.asset(Utils.getImgPath(erroAssetName)),
        ),
      ),
    );
  }
}
