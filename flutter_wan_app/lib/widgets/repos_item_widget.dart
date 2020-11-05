import 'package:flutter/material.dart';
import '../data/protocol/protocols.dart';
import '../common/common.dart';
import '../common/colors.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/status_widget.dart';
import '../tools/utils.dart';

class ReposItem extends StatelessWidget {
  final String labelId;
  final ReposModel model;
  final bool isHome;

  const ReposItem({Key key, this.labelId, this.model, this.isHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        print('点击了文章');
      },
      child: Container(
        height: 160,
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
                  Expanded(
                    child: Text(
                      model.desc,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.listContent,
                    ),
                  ),
                  Gaps.vGap10,
                  Row(
                    children: [
                      LikeBtn(
                        labelId: labelId,
                        id: model.originId ?? model.id,
                        isLike: model.collect,
                      ),
                      Gaps.hGap10,
                      Text(
                        model.author,
                        style: TextStyles.listExtra,
                      ),
                      Gaps.hGap10,
                      Text(
                        Utils.getTimeLine(context, model.publishTime),
                        style: TextStyles.listExtra,
                      )
                    ],
                  )
                ],
              ),
            ),

            // 图片
            Container(
              width: 72,
              margin: EdgeInsets.only(left: 10),
              child: CachedNetworkImage(
                width: 72,
                height: 128,
                fit: BoxFit.fill,
                imageUrl: model.envelopePic,
                placeholder: (cxt, url) {
                  return ProgressView();
                },
                errorWidget: (ctx, url, err) {
                  return Icon(Icons.error);
                },
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.33, color: Colours.divider))),
      ),
    );
  }
}
