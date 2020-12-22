import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'action_input_dialog.dart';
export 'action_input_dialog.dart';

typedef ActionRowsSelect = void Function(int index, String title);

class ActionSheet {
  // 评论和键盘弹出
  static void commentSheet(
    BuildContext context, {
    FocusNode focusNode,
    TextEditingController textEditingController,
    String palcehold = '',
    ActionInputSelect submitAction,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ActionInpuDialog(
            placehold: palcehold,
            focusNode: focusNode,
            textController: textEditingController,
            submitAction: submitAction,
          );
        });
  }

  // 从底部弹出
  static void bottomSheet(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black45,
      builder: (ctx) => child,
    );
  }

  static void showActionSheet(
    BuildContext context, {
    List<String> rows,
    bool showCancel = true,
    ActionRowsSelect selectAction,
  }) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (ctx) {
          return TKActionSheetWidget(
            rows: rows,
            showCancel: showCancel,
            selectAction: selectAction,
          );
        });
  }
}

class TKActionSheetWidget extends StatelessWidget {
  final List<String> rows;
  final bool showCancel;
  final ActionRowsSelect selectAction;

  TKActionSheetWidget({
    Key key,
    @required List<String> rows,
    this.showCancel = true,
    this.selectAction,
  })  : rows = rows ?? [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final cellHeight = (rows.length + 1) * 55 + 8 + 20;
    final safeHeight = MediaQuery.of(context).padding.bottom;
    return Container(
      height: cellHeight + safeHeight,
      child: Column(
        children: renderItemList(context),
      ),
    );
  }

  List<Widget> renderItemList(BuildContext context) {
    List<Widget> lists = [];

    for (var i = 0; i < rows.length; i++) {
      Widget itemWidget = GestureDetector(
        child: Container(
          color: Colors.white,
          width: ScreenUtil().screenWidth,
          height: 55,
          alignment: Alignment.center,
          child: Text(
            rows[i],
            style: TextStyle(fontSize: 16, color: Color(0xFF1a1a1a)),
          ),
        ),
        onTap: () {
          selectAction(i, rows[i]);
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
      );
      lists.add(itemWidget);
      if (i < rows.length - 1) {
        lists.add(Divider(
            height: 0.5, indent: 16, endIndent: 16, color: Color(0xFFe5e5e5)));
      }
    }
    lists.add(Divider(thickness: 8, height: 8, color: Color(0xFFe5e5e5)));

    Widget cancelWidget = GestureDetector(
      child: Container(
        width: ScreenUtil().screenWidth,
        height: 55,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          '取消',
          style: TextStyle(fontSize: 16, color: Color(0xFF999999)),
        ),
      ),
      onTap: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      },
    );
    lists.add(cancelWidget);

    return lists;
  }
}
