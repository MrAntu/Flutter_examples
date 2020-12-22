import 'package:flutter/material.dart';
import 'find_detail_content.dart';
import '../../../providers/find_detail_provider.dart';
import '../../../exports.dart';
import 'comment_replay_item.dart';

/// 发现列表点击事件
typedef FindActionCallBack = void Function(FindActionType type);

class CommentItem extends StatelessWidget {
  final CommentModel model;
  final int userId;
  final FindActionCallBack actionCallBack;
  CommentItem({this.model, this.userId, this.actionCallBack, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xFFf7f7f7)))),
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderFirstCommentItem(),
      ),
    );
  }

  List<Widget> renderFirstCommentItem() {
    List<Widget> itemList = [];

    itemList.add(renderUserInfo());
    itemList.add(renderCommentInfo());

    if (model.commentReplyVOs != null && model.commentReplyVOs.length > 0) {
      itemList.add(CommentReplyItem(
          replyLists: model.commentReplyVOs, userId: userId, key: key));
    }

    return itemList;
  }

  Widget renderUserInfo() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[renderUserLeft(), renderUserRight()],
      ),
    );
  }

  Widget renderCommentInfo() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 36, right: 20, top: 3),
        child: Text(model.commentInfo,
            style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
      ),
      onTap: () {
        actionCallBack(FindActionType.commentSelect);
      },
    );
  }

  Widget renderUserLeft() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: ExtendCachedNetworkImage(
            imageUrl: model.headImg ?? '',
            width: 30,
            height: 30,
            corner: 20,
          ),
          onTap: () {
// 直接进去就好
          },
        ),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: renderTitleItem()),
            Text(model.publishTime,
                style: TextStyle(fontSize: 10, color: Color(0xFF999999)))
          ],
        )
      ],
    );
  }

  Widget renderUserRight() {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Icon(
            model.agreeStatus == '1' ? Icons.favorite : Icons.favorite_border,
            color: model.agreeStatus == '1'
                ? Color(0xFF999999)
                : Color(0xFF999999),
            size: 20,
          ),
          Text('${model.cntAgree}',
              style: TextStyle(fontSize: 10, color: Color(0xFF666666)))
        ],
      ),
      onTap: () {
        actionCallBack(FindActionType.agree);
      },
    );
  }

  List<Widget> renderTitleItem() {
    List<Widget> itemList = [];

    Widget title = Text(model.nickname,
        style: TextStyle(fontSize: 14, color: Color(0xFF666666)));
    itemList.add(title);
    itemList.add(SizedBox(width: 4));

    if (userId == model.userId) {
      Widget logo = Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2), color: Color(0xFF79b7f7)),
        child: Text('作者', style: TextStyle(fontSize: 9, color: Colors.white)),
      );
      itemList.add(logo);
    }

    return itemList;
  }
}
