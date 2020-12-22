import 'package:flutter/material.dart';
import '../../exports.dart';
import 'views/skeleton_recommend.dart';

class FindRecommendPage extends StatefulWidget {
  const FindRecommendPage({Key key}) : super(key: key);

  @override
  _FindRecommendPageState createState() => _FindRecommendPageState();
}

class _FindRecommendPageState extends State<FindRecommendPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SkeletonList(
              builder: (ctx, index) => SkeleRecommend(),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
