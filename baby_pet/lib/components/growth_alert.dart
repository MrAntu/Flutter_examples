import 'package:flutter/material.dart';
import '../utils/utils.dart';

class GrowthAlert extends StatelessWidget {
  const GrowthAlert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titles = ['日常打卡', '健康管理', '体重记录'];
    final images = ['home_record', 'home_fit', 'home_weight'];
    return Container(
      height: MediaQuery.of(context).padding.bottom + 120,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom, top: 35),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: images.map((e) {
          final index = images.indexOf(e) ?? 0;
          return GestureDetector(
            onTap: () {
              print(index);
            },
            child: Column(
              children: [
                Image.asset(
                  Utils.getImgPath(e),
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  titles[index],
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF333333),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
