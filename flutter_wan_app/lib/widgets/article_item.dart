import 'package:flutter/material.dart';
import '../data/protocol/protocols.dart';
import '../tools/utils.dart';
import '../common/colors.dart';
import '../common/common.dart';
import 'status_widget.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem(
    this.model, {
    Key key,
    this.labelId,
    this.isHome,
  }) : super(key: key);
  final ReposModel model;
  final String labelId;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('点击了公众号');
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listTitle,
                  ),
                  Gaps.vGap10,
                  Text(
                    model.desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.listContent,
                  ),
                  Gaps.vGap5,
                  new Row(
                    children: <Widget>[
                      new LikeBtn(
                        labelId: labelId,
                        id: model.originId ?? model.id,
                        isLike: model.collect,
                      ),
                      Gaps.hGap10,
                      new Text(
                        model.author,
                        style: TextStyles.listExtra,
                      ),
                      Gaps.hGap10,
                      new Text(
                        Utils.getTimeLine(context, model.publishTime),
                        style: TextStyles.listExtra,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 12),
              child: CircleAvatar(
                radius: 28,
                backgroundColor:
                    Utils.getCircleBg(model.superChapterName ?? "公众号"),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    model.superChapterName ?? "公众号",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.33, color: Colours.divider)),
      ),
    );
  }
}
