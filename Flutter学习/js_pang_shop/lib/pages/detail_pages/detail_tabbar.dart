import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail_provider.dart';
class DetailTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (context, detail, child) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          height: ScreenUtil().setHeight(80),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _tabbarItem(detail, 1),
              ),
              Expanded(
                child: _tabbarItem(detail, 2),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tabbarItem(DetailProvider provider, int diretion) {
    bool _isClick = false;
    String _title = "";
    //左边
    if (diretion == 1) {
      _isClick = provider.isLeft ? true : false;
      _title = "详情";
    }
    // 右边
    if (diretion == 2) {
      _isClick = provider.isRight ? true : false;
      _title = "评论";
    }

    return InkWell(
      onTap: () {
        String text = 'left';
        if (diretion == 2) {
          text = 'right';
        }
        provider.changeTabbarDirection(text);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 1, color: _isClick ? Colors.pink : Colors.white)
            )
        ),
        child: Text(_title,
          style: TextStyle(
              color: _isClick ? Colors.pink : Colors.black,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}
