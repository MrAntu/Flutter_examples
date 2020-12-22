import 'package:flutter/material.dart';
import '../../../providers/find_detail_provider.dart';
import '../../../exports.dart';

class CommentReplyItem extends StatefulWidget {
  final List<CommentReplyVo> replyLists;
  final int userId;
  CommentReplyItem({this.replyLists, this.userId, Key key}) : super(key: key);

  @override
  _CommentReplyItemState createState() => _CommentReplyItemState();
}

class _CommentReplyItemState extends State<CommentReplyItem> {
  bool _showAll = false;
  int _maxCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, top: 10),
      child: Column(
        children: renderAllComment(),
      ),
    );
  }

  List<Widget> renderAllComment() {
    final commentCount = widget.replyLists.length;

    int showCount = commentCount;
    if (commentCount > _maxCount) {
      showCount = _showAll ? commentCount : _maxCount;
    }

    List<Widget> commentList = [];
    for (var i = 0; i < showCount; i++) {
      commentList.add(renderCommentItem(widget.replyLists[i]));
    }

    if (commentCount > _maxCount) {
      commentList.add(renderShowAllButton());
    }

    return commentList;
  }

  Widget renderCommentItem(CommentReplyVo model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: renderUserInfoItems(model)),
          renderCommentInfo(model)
        ],
      ),
    );
  }

  List<Widget> renderUserInfoItems(CommentReplyVo model) {
    List<Widget> commentList = [];

    Widget headerImage = GestureDetector(
      child: ExtendCachedNetworkImage(
        imageUrl: model.headImg ?? '',
        width: 18,
        height: 18,
        corner: 10,
      ),
      onTap: () {},
    );
    commentList.add(headerImage);

    Widget title = Text(model.replyNickname,
        style: TextStyle(fontSize: 14, color: Color(0xFF666666)));
    commentList.add(SizedBox(width: 4));
    commentList.add(title);

    Widget time = Text(model.replyPublishTime,
        style: TextStyle(fontSize: 11, color: Color(0xFF999999)));
    commentList.add(SizedBox(width: 4));
    commentList.add(time);

    if (widget.userId == model.replyUserId) {
      Widget logo = Container(
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2), color: Color(0xFF79b7f7)),
        child: Text('作者', style: TextStyle(fontSize: 9, color: Colors.white)),
      );
      commentList.add(SizedBox(width: 4));
      commentList.add(logo);
    }

    return commentList;
  }

  Widget renderCommentInfo(CommentReplyVo model) {
    String nickName = model.nickname + ': ';
    return Container(
        padding: EdgeInsets.only(left: 24, right: 20, top: 3),
        child: Text.rich(TextSpan(children: [
          WidgetSpan(
              child: Text('回复',
                  style: TextStyle(fontSize: 13, color: Color(0xFF666666))),
              alignment: PlaceholderAlignment.middle),
          ...nickName.runes.map((rune) {
            return WidgetSpan(
                child: Text(String.fromCharCode(rune),
                    style: TextStyle(fontSize: 14, color: Color(0xFF526e94))),
                alignment: PlaceholderAlignment.middle);
          }).toList(),
          ...model.commentInfo.runes.map((rune) {
            return WidgetSpan(
                child: Text(String.fromCharCode(rune),
                    style: TextStyle(fontSize: 13, color: Color(0xFF333333))),
                alignment: PlaceholderAlignment.middle);
          }).toList(),
        ])));
  }

  Widget renderShowAllButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Text.rich(TextSpan(children: [
          WidgetSpan(
              child: Text(_showAll ? '收起' : '展开所有',
                  style: TextStyle(fontSize: 13, color: Color(0xFF526e94))),
              alignment: PlaceholderAlignment.middle),
          WidgetSpan(
              child: Icon(Icons.arrow_drop_down,
                  size: 14, color: Color(0xFF526e94)),
              alignment: PlaceholderAlignment.middle),
        ])),
      ),
      onTap: () {
        setState(() {
          _showAll = !_showAll;
        });
      },
    );
  }
}
