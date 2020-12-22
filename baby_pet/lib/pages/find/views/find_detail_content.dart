import 'package:flutter/material.dart';
import '../../../models/detail_model.dart';
import 'find_item_image.dart';
import '../../../exports.dart';

enum FindActionType {
  // 进入详情页面
  detail,
  // 点击头像, 进入个人主页
  header,
  // 点赞
  agree,
  // 收藏
  collection,
  // 关注
  attation,
  // 评论
  comment,
  // 点击评论
  commentSelect,
  // 分享
  share,
  // 空
  none
}

/// 个人主页事件类型
enum FindHeaderActionType {
  fansList,
  focusList,
  agreeList,
}

/// 发现列表点击事件
typedef FindActionCallBack = void Function(FindActionType type);

/// 个人主页header事件
typedef FindHeaderCallback = void Function(FindHeaderActionType type);

/// 评论提交
typedef ActionTextSubmit = void Function(String text);

class FindDetailContent extends StatelessWidget {
  final DetailModel model;
//  final FindActionCallBack eventAction;
  FindDetailContent(this.model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, left: 16, right: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getItemList(context)),
          ),
          Container(height: 10, color: Color(0xFFf7f7f7))
        ],
      ),
    );
  }

  List<Widget> getItemList(BuildContext context) {
    List<Widget> itemList = [];
    itemList.add(userInfoItem(context));

    if (model.labelName != null && model.labelName.isNotEmpty) {
      itemList.add(SizedBox(height: 10));
      itemList.add(renderTopicItem());
    }

    if (model.messageInfo != null && model.messageInfo.isNotEmpty) {
      itemList.add(SizedBox(height: 10));
      itemList.add(renderTextItem(context));
    }

    if (model.files != null && model.files.length > 0) {
      itemList.add(renderMediaItems(context));
    }

    if (model.city != null && model.city.isNotEmpty) {
      itemList.add(renderLocationItem());
    }

    itemList.add(SizedBox(height: 8));
    itemList.add(Divider(color: Color(0xFFe8e8e8), height: 0.5));
    itemList.add(renderBottomItem(context));
    return itemList;
  }

  Widget userInfoItem(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: ExtendCachedNetworkImage(
                imageUrl: model.headImg ?? '',
                width: 45,
                height: 45,
                corner: 30,
              ),
              onTap: () {
//                eventAction(FindActionType.header);
              },
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.nickName ?? '',
                    style: TextStyle(fontSize: 15, color: Color(0xFF333333))),
                Text(model.createTime ?? '',
                    style: TextStyle(fontSize: 11, color: Color(999999))),
              ],
            )
          ],
        ),
        RaisedButton(
          onPressed: () {},
          color: Colors.yellow,
          child: Text('+关注'),
        ),
      ],
    );
  }

  Widget renderTopicItem() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text('#' + model.labelName ?? '',
          style: TextStyle(fontSize: 10, color: Colors.yellow)),
    );
  }

  Widget renderTextItem(BuildContext context) {
    return Text(
      model.messageInfo ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
    );
  }

  Widget renderMediaItems(BuildContext context) {
    final media = model.files.first;
    if (media.fileType == '0') {
      return renderImages(context);
    }
    return Container();
  }

  Widget renderImages(BuildContext context) {
    final imgArray = model.files;
    if (imgArray.length == 1) {
      final imgModel = imgArray.first;
      return Container(
        padding: EdgeInsets.only(top: 8),
        child: FindItemImage(
          imageUrl: imgModel.fileUrl,
          width: 140,
          height: 180,
          radius: 10,
          onPress: () {},
        ),
      );
    }
    final imageWidth = imgArray.length == 4 ? 120.0 : 107.0;
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: imgArray.map((item) {
          final itemIndex = imgArray.indexOf(item);
          return FindItemImage(
            imageUrl: item.fileUrl,
            width: imageWidth,
            height: imageWidth,
            radius: 4,
            onPress: () {
//              List<String> images = imgArray.map((e) => e.fileUrl).toList();
//              TKRoute.pushImagePreview(
//                  context, PhotoPreview(index: itemIndex, images: images));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget renderLocationItem() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Icon(Icons.location_on, size: 16, color: Color(0xFF666666)),
          SizedBox(width: 4),
          Text(model.city,
              style: TextStyle(fontSize: 13, color: Color(0xFF6f6f6f)))
        ],
      ),
    );
  }

  Widget renderBottomItem(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getBottomItem(),
      ),
    );
  }

  List<Widget> getBottomItem() {
    List<Widget> itemList = [];

    itemList.add(bottomItem(
        model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
        model.agreeStatus == '1' ? Color(0xFF6f6f6f) : Color(0xFF6f6f6f),
        '${model.cntAgree}',
        FindActionType.agree));
    itemList.add(bottomItem(
        model.collectionsStatus == '1' ? Icons.star : Icons.star_border,
        model.collectionsStatus == '1' ? Color(0xFF6f6f6f) : Color(0xFF6f6f6f),
        model.collectionNum,
        FindActionType.collection));
    itemList.add(bottomItem(Icons.message, Color(0xFF6f6f6f), model.commentNum,
        FindActionType.comment));
    itemList.add(
        bottomItem(Icons.share, Color(0xFF6f6f6f), '', FindActionType.share));

    return itemList;
  }

  Widget bottomItem(
      IconData icon, Color iconColor, String number, FindActionType type) {
    return GestureDetector(
      child: Container(
        width: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            SizedBox(width: 3),
            Text('$number',
                style: TextStyle(fontSize: 13, color: Color(0xFF6f6f6f)))
          ],
        ),
      ),
      onTap: () {
//        eventAction(type);
      },
    );
  }
}
