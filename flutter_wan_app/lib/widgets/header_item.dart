import 'package:flutter/material.dart';
import '../tools/utils.dart';
import '../common/strings.dart';
import '../common/common.dart';
import '../common/colors.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem(
      {this.margin,
      this.titleColor,
      this.leftIcon,
      this.titleId: Ids.titleRepos,
      this.title,
      this.extraId: Ids.more,
      this.extra,
      this.rightIcon,
      this.onTap,
      Key key})
      : super(key: key);

  final EdgeInsetsGeometry margin;
  final Color titleColor;
  final IconData leftIcon;
  final String titleId;
  final String title;
  final String extraId;
  final String extra;
  final IconData rightIcon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: margin ?? EdgeInsets.only(top: 0),
      child: ListTile(
//        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        title: Row(
          children: [
            Icon(
              leftIcon ?? Icons.whatshot,
              color: titleColor ?? Colors.blueAccent,
            ),
            Gaps.hGap10,
            Text(
              title ?? Ids.recRepos,
              style: TextStyle(
                  color: titleColor ?? Colors.blueAccent,
                  fontSize: Utils.getTitleFontSize(title ?? titleId)),
            )
          ],
        ),
        trailing: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                extra ?? Ids.more,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              Icon(
                rightIcon ?? Icons.keyboard_arrow_right,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.33, color: Colours.divider))),
    );
  }
}
