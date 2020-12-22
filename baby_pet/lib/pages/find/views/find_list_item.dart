import 'package:flutter/material.dart';
import '../../../providers/find_focus_provider.dart';
import '../../../exports.dart';
import 'find_item_image.dart';
import 'find_item_video.dart';

class FindListItem extends StatelessWidget {
  final FocusPostModel model;

  const FindListItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        jumpFindDetail(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _renderListItem(context),
            ),
          ),
          // 底部空隙
          Container(height: 10, color: Color(0xFFf7f7f7)),
        ],
      ),
    );
  }

  void jumpFindDetail(BuildContext context) {
    RouteUtil.push(context, Routes.findDetail, model.messageId);
  }

  List<Widget> _renderListItem(BuildContext context) {
    List<Widget> list = [];
    // 用户信息
    list.add(_userInfoItem());
    // 信息
    if (!ObjectUtil.isEmptyString(model.messageInfo)) {
      list.add(SizedBox(height: 10));
      list.add(_renderTextItem());
    }
    // 图片或视频
    if (model.fileCount > 0) {
      list.add(_renderMediaItems());
    }
    // 定位
    if (!ObjectUtil.isEmptyString(model.userInfo.city)) {
      list.add(_renderLocation());
    }
    // 评论
    if (!ObjectUtil.isEmptyList(model.commentList)) {
      list.add(SizedBox(height: 10));
      list.add(_renderCommonList());
    }
    list.add(SizedBox(height: 8));
    list.add(Divider(color: Color(0xFFe8e8e8), height: 0.5));
    list.add(_renderBottomItem());
    return list;
  }

  Widget _renderBottomItem() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _getBottomItems(),
      ),
    );
  }

  List<Widget> _getBottomItems() {
    List<Widget> list = [];
    list.add(_bottomItem(
        Icons.favorite_border, Color(0xFF666666), '${model.cntAgree}'));
    list.add(
        _bottomItem(Icons.message, Color(0xFF666666), '${model.cntComment}'));
    list.add(_bottomItem(Icons.share, Color(0xFF666666), ''));

    return list;
  }

  Widget _bottomItem(IconData icon, Color iconColor, String number) {
    return Container(
      width: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: iconColor),
          SizedBox(width: 3),
          Text(
            number,
            style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
          )
        ],
      ),
    );
  }

  Widget _renderCommonList() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFf7f7f7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _renderCommonChildren(),
        ),
      ),
    );
  }

  List<Widget> _renderCommonChildren() {
    List<CommentModel> newList = model.commentList.length > 3
        ? model.commentList.sublist(0, 3)
        : model.commentList;

    List<Widget> list = [];
    var index = 0;
    newList.forEach(
      (element) {
        Widget span = Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Text(
                  element.nickname + ': ',
                  style: TextStyle(fontSize: 13, color: Color(0xFF526e94)),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              ...element.commentInfo.runes.map((rune) {
                return WidgetSpan(
                  child: Text(
                    String.fromCharCode(rune),
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF666666),
                    ),
                  ),
                  alignment: PlaceholderAlignment.middle,
                );
              }).toList(),
            ],
          ),
          softWrap: true,
        );
        list.add(span);
        if (index < newList.length - 1) {
          list.add(SizedBox(height: 3));
        }
        index++;
      },
    );

    if (model.commentList.length > 3) {
      list.add(SizedBox(height: 5));
      Widget spanIcon = Text.rich(TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              '查看更多评论',
              style: TextStyle(fontSize: 13, color: Color(0xFF526e94)),
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          WidgetSpan(
            child: Icon(
              Icons.keyboard_arrow_right,
              size: 20,
              color: Color(0xFF526e94),
            ),
            alignment: PlaceholderAlignment.middle,
          )
        ],
      ));
      list.add(spanIcon);
    }

    return list;
  }

  Widget _renderLocation() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(Icons.location_on, size: 16, color: Colors.grey),
          SizedBox(width: 4),
          Text(
            model.userInfo.city,
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _renderMediaItems() {
    final media = model.fileList.first;
    // 图片
    if (media.fileType == '0') {
      return _renderImages();
    } else if (media.fileType == '1') {
      // 视频
      return _renderVideoItem();
    }
    return Container();
  }

  Widget _renderVideoItem() {
    final imgArray = model.fileList;
    final imgModel = imgArray.first;
    return GestureDetector(
      child: FindItemVedio(videoURL: imgModel.fileUrl),
      onTap: () {
        print("12313");
      },
    );
  }

  Widget _renderImages() {
    final imgArr = model.fileList;
    if (imgArr.length == 1) {
      final imgModel = imgArr.first;
      return Container(
        padding: EdgeInsets.only(top: 8),
        child: FindItemImage(
          imageUrl: imgModel.fileUrl,
          width: 140,
          height: 180,
          radius: 10,
          onPress: () {
            print("123123");
          },
        ),
      );
    }

    // 多张图片
    final imageWidth = imgArr.length == 4 ? 120.0 : 107.0;
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: imgArr.map((e) {
          final itemIndex = imgArr.indexOf(e);
          return FindItemImage(
            key: ValueKey(itemIndex),
            imageUrl: e.fileUrl,
            width: imageWidth,
            height: imageWidth,
            radius: 4,
            onPress: () {
              print('123123');
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _renderTextItem() {
    return Text(
      model.messageInfo,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _userInfoItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _userInfoHeader(),
        // 关注按钮
        RaisedButton(
          onPressed: () {},
          color: Colors.yellow,
          shape: StadiumBorder(),
          child: Text('已关注'),
        )
      ],
    );
  }

  Widget _userInfoHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: ExtendCachedNetworkImage(
            imageUrl: model.userInfo.headImg,
            width: 45,
            height: 45,
            corner: 22.5,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.userInfo.nickname,
              style: TextStyle(fontSize: 11),
            ),
            Text(
              model.createTime,
              style: TextStyle(fontSize: 11),
            ),
          ],
        )
      ],
    );
  }
}
