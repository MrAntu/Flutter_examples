import 'package:flutter/material.dart';

class DetailExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      child: Text(
        "说明：> 急速送达 > 正品保证",
        style: TextStyle(
          color: Colors.red,
          fontSize: 16
        ),
      ),
    );
  }
}
