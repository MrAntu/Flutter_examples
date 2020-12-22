import 'package:flutter/material.dart';
import '../../../exports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../components/animated_widget.dart';

class HomeHeader extends StatelessWidget {
  final bool scrollTop;
  // window.padding.top 为状态栏高度

  HomeHeader({Key key, this.scrollTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusHeight = MediaQuery.of(context).padding.top;
    final flexHeaderHeight = 210 + statusHeight;

    return SliverAppBar(
      pinned: true,
      expandedHeight: flexHeaderHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
//          color: Theme.of(context).primaryColor,
          color: Color(0xFFfafafa),
          child: Container(
            child: Stack(
              children: [
                _initBackImg(context),
                _initRightSelect(context),
                _initAnimalInfo(context),
                _initAnimalLifes(context),
              ],
            ),
          ),
        ),
      ),
      actions: [
        EmptyAnimatedSwitcher(
          child: _renderRightItem(),
          display: scrollTop,
        ),
        SizedBox(
          width: 12,
        )
      ],
      leading: EmptyAnimatedSwitcher(
        display: scrollTop,
        child: GestureDetector(
          child: _renderAnimalHeader(40, context),
        ),
      ),
    );
  }

  Widget _initAnimalLifes(BuildContext context) {
    final titles = ['日常打卡', '健康管理', '体重记录', '新手帮助', '喂养指导'];
    final images = [
      'home_record',
      'home_fit',
      'home_weight',
      'home_album',
      'home_warn'
    ];
    return Positioned(
      bottom: 0,
      left: 15,
      child: Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFF1F1F1),
                    offset: Offset(-2, -2),
                    blurRadius: 5),
                BoxShadow(
                    color: Color(0xFFF1F1F1),
                    offset: Offset(2, 2),
                    blurRadius: 5),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: titles.map((e) {
              int index = titles.indexOf(e);
              return GestureDetector(
                onTap: () {
                  print(index);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Utils.getImgPath(images[index]),
                        fit: BoxFit.cover,
                        width: 38,
                        height: 38,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        titles[index],
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF5D5D5D),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  Widget _initAnimalInfo(BuildContext context) {
    return Positioned(
      left: 20,
      top: 90,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _renderAnimalHeader(70, context),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _animalInfoColumn(),
          )
        ],
      ),
    );
  }

  List<Widget> _animalInfoColumn() {
    List<Widget> lists = [];

    if (CommonTool.hasLogin()) {
      lists.add(Text(CommonTool.loginInfo.nickname ?? ''));
    } else {
      lists.add(Text('未登录'));
    }

    return lists;
  }

  Widget _renderAnimalHeader(double size, BuildContext context) {
    return ExtendCachedNetworkImage(
      height: size,
      width: size,
      imageUrl: '',
      corner: size / 2,
      erroAssetName: 'animal_icon',
      onTap: () {
        RouteUtil.push(context, Routes.petAdd, CommonTool.petModel);
      },
    );
  }

  Widget _initRightSelect(BuildContext context) {
    final statusHeight = MediaQuery.of(context).padding.top;
    return Positioned(
      right: 15,
      top: statusHeight,
      child: _renderRightItem(),
    );
  }

  Widget _renderRightItem() {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 6, 4, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '添加宠物',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 24,
                color: Color(0xFF1a1a1a),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _initBackImg(BuildContext context) {
    final statusHeight = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200 + statusHeight,
      child: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.dstOver),
        child: Image.asset(
          Utils.getImgPath('home_back'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
