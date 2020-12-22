import 'package:flutter/material.dart';

class StickTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  StickTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      color: Colors.white,
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
