import 'package:flutter/material.dart';
import 'find_detail_content.dart';
import '../../../exports.dart';

class FindBottomTool extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ActionTextSubmit submitAction;
  final FindActionCallBack actionCallback;
  final bool agreeState;
  final bool collectionState;
  final String agreeCount;
  final String collectionCount;
  final Color backcolorColor;
  final Color inputBackColor;
  final Color mainColor;
  final bool showBorder;

  FindBottomTool({
    this.focusNode,
    this.controller,
    this.submitAction,
    this.actionCallback,
    this.agreeState = false,
    this.collectionState = false,
    this.agreeCount = '0',
    this.collectionCount = '0',
    this.backcolorColor = Colors.white,
    this.mainColor = Colors.yellow,
    this.inputBackColor = Colors.grey,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      color: backcolorColor,
      padding: EdgeInsets.only(bottom: 0, right: 0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding:
                    EdgeInsets.only(left: 12, right: 30, top: 7, bottom: 7),
                decoration: BoxDecoration(
                    color: inputBackColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text('快来评论小可爱吧...',
                    style: TextStyle(fontSize: 15, color: mainColor)),
              ),
              onTap: () {
                ActionSheet.commentSheet(context,
                    focusNode: focusNode,
                    textEditingController: controller,
                    palcehold: '快来评论小可爱吧...', submitAction: (text) {
                  print(text);
                });
              },
            ),
            Row(
              children: <Widget>[
                bottomItem(agreeState ? Icons.favorite : Icons.favorite_border,
                    mainColor, agreeCount, 0),
                SizedBox(width: 30),
                bottomItem(Icons.star, mainColor, collectionCount, 1)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomItem(IconData icon, Color iconColor, String number, int index) {
    return GestureDetector(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            Text('$number', style: TextStyle(fontSize: 13, color: mainColor))
          ],
        ),
      ),
      onTap: () {
        if (index == 0) {
          actionCallback(FindActionType.agree);
        } else if (index == 1) {
          actionCallback(FindActionType.collection);
        }
      },
    );
  }
}
