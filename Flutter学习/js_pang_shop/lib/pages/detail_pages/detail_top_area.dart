import 'package:flutter/material.dart';
import '../../provide/detail_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _goodsImage(),
              _goodsTitle(),
              _goodsNum(),
              _goodsPrice()
            ],
          );
        },
      ),
    );
  }

  Widget _goodsImage() {
    return Image.network("https://img12.360buyimg.com/mobilecms/s255x255_jfs/t25624/62/1780421997/148516/ae0f87ec/5bbc3270Neeede37e.jpg!cc_255x255.webp",
      width: ScreenUtil().setWidth(750),
      fit: BoxFit.cover,
    );
  }

  Widget _goodsTitle() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "茅台集团 习酒 方品习酱 53度 礼盒装白酒500ml单瓶 酱香型酒水",
        maxLines: 2,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18
        ),
      ),
    );
  }

  Widget _goodsNum() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "编号：${8808123123131}",
        style: TextStyle(
          color: Colors.black38,
          fontSize: 16
        ),
      ),
    );
  }

  Widget _goodsPrice() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Text(
            "￥ 288.00",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 18
            ),
          ),
          SizedBox(width: 30,),
          Text(
            "市场价：",
            style: TextStyle(
              color: Colors.black12,
              fontSize: 16,
            ),
          ),
          Text(
            "￥ 499.00",
            style: TextStyle(
              decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }


}
