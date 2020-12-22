import 'package:flutter/material.dart';
import '../../../exports.dart';

class PetSelectCell extends StatelessWidget {
  final GestureTapCallback onTap;
  final String leftTitle;
  final String rightTitle;

  PetSelectCell({Key key, this.onTap, this.leftTitle, this.rightTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 16),
            _topWidget(),
            SizedBox(height: 15.5),
            _bottomLine(),
          ],
        ),
      ),
    );
  }

  Widget _topWidget() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftTitle,
            style: TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Text(
                rightTitle ?? '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 5),
              // 箭头
              Icon(Icons.keyboard_arrow_right, size: 28),
              SizedBox(width: 6),
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomLine() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
//          color: Colors.black,
          color: Color(0xFFe8e8e8),
          height: 0.5,
        ),
      ),
    );
  }
}
