import 'package:flutter/material.dart';
import '../../../exports.dart';

class SkeleRecommend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFf7f7f7)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SkeletonContainer(width: ScreenUtil().screenWidth - 80, height: 20),
          SizedBox(height: 4),
          Row(
            children: <Widget>[
              SkeletonContainer(width: 16, height: 16, isCircle: true),
              SizedBox(width: 4),
              SkeletonContainer(width: 100, height: 14),
              SizedBox(width: 4),
              SkeletonContainer(width: 40, height: 14),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SkeletonContainer(
                      width: ScreenUtil().screenWidth - 160, height: 15),
                  SizedBox(height: 4),
                  SkeletonContainer(
                      width: ScreenUtil().screenWidth - 160, height: 15),
                  SizedBox(height: 4),
                  SkeletonContainer(
                      width: ScreenUtil().screenWidth - 280, height: 15),
                ],
              ),
              SizedBox(width: 16),
              SkeletonContainer(width: 95, height: 70),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              SkeletonContainer(width: 16, height: 16),
              SizedBox(width: 30),
              SkeletonContainer(width: 16, height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
