import 'package:flutter/material.dart';
import '../../../models/grass_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../exports.dart';

typedef HomeActionCallBack = void Function(GrassModel grassModel);

class HomeGridItem extends StatelessWidget {
  final GrassModel model;
  final HomeActionCallBack actionCallBack;

  const HomeGridItem({Key key, this.model, this.actionCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        actionCallBack(model);
      },
      child: Container(
//        width: (ScreenUtil().screenWidth - 25) / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderHeaderImage(),
            _renderBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _renderHeaderImage() {
    final imageW = (ScreenUtil().screenWidth - 25) / 2;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: CachedNetworkImage(
        height: imageW,
        width: imageW,
        fit: BoxFit.cover,
        imageUrl: model.fileUrl ?? "",
        errorWidget: (context, url, error) =>
            Image.asset(Utils.getImgPath('find_empty_img')),
      ),
    );
  }

  Widget _renderBottom(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _renderChildren(context),
      ),
    );
  }

  List<Widget> _renderChildren(BuildContext context) {
    List<Widget> itemList = [];
    itemList.add(_renderUserInfo());
    if (!ObjectUtil.isEmptyString(model.labelName)) {
      itemList.add(SizedBox(height: 4));
      itemList.add(_renderTopicItem(context));
    }

    if (!ObjectUtil.isEmptyString(model.messageInfo)) {
      itemList.add(SizedBox(height: 4));
      itemList.add(_renderMessageItem(context));
    }
    itemList.add(SizedBox(height: 4));
    itemList.add(_renderNumberItem());
    return itemList;
  }

  Widget _renderNumberItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _renderBottomItem(
          model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
          Color(0xFFC6C6C6),
          model.messageAgreenum,
        ),
        _renderBottomItem(
          Icons.remove_red_eye,
          Color(0xFFC6C6C6),
          model.messageAgreenum,
        ),
      ],
    );
  }

  Widget _renderBottomItem(IconData icon, Color iconColor, String number) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 14,
        ),
        SizedBox(width: 4),
        Text(
          number ?? "",
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFC6C6C6),
          ),
        )
      ],
    );
  }

  Widget _renderMessageItem(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 0.5),
              ),
              child: Text(
                '种草',
                style: TextStyle(
                    fontSize: 9, color: Theme.of(context).primaryColor),
              ),
            )),
            TextSpan(
                text: ' ' + model.messageInfo,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF868686),
                )),
          ],
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _renderTopicItem(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        '#' + model.labelName,
        style: TextStyle(
          fontSize: 10,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _renderUserInfo() {
    return Container(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              height: 20,
              width: 20,
              fit: BoxFit.cover,
              imageUrl: model.headImg ?? "",
              errorWidget: (context, url, error) =>
                  Image.asset(Utils.getImgPath('find_empty_img')),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              model.nickname ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5D5D5D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
