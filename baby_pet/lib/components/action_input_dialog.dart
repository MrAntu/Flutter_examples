import 'package:flutter/material.dart';
import 'dart:ui' as ui;

typedef ActionInputSelect = void Function(String text);

class ActionInpuDialog extends StatefulWidget {
  final String placehold;
  final FocusNode focusNode;
  final TextEditingController textController;
  final ActionInputSelect submitAction;

  ActionInpuDialog({
    Key key,
    @required this.placehold,
    this.focusNode,
    this.textController,
    this.submitAction,
  }) : super(key: key);

  @override
  _ActionInpuDialogState createState() => _ActionInpuDialogState();
}

class _ActionInpuDialogState extends State<ActionInpuDialog>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var bottom = MediaQueryData.fromWindow(ui.window).viewInsets.bottom;
    return AnimatedContainer(
      color: Colors.transparent,
      duration: Duration(milliseconds: 200),
      // alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: bottom),
      child: Material(
        child: Container(
          height: 50,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[renderTextInput(), renderSenderButton()],
          ),
        ),
      ),
    );
  }

  Widget renderTextInput() {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.text,
        focusNode: widget.focusNode,
        controller: widget.textController,
        autofocus: true,
        maxLines: 1,
        style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
        textInputAction: TextInputAction.send,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          hintText: widget.placehold,
          hintStyle: TextStyle(fontSize: 14, color: Color(0XFFcccccc)),
          counterText: '',
          filled: true,
          fillColor: Color(0xFFf7f7f7),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.none, color: Colors.transparent),
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.none, color: Colors.transparent),
              borderRadius: BorderRadius.circular(30)),
        ),
        onSubmitted: (text) {
          widget.focusNode.unfocus();
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          widget.submitAction(text);
        },
      ),
    );
  }

  Widget renderSenderButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: Center(
          child:
              Text('发送', style: TextStyle(fontSize: 16, color: Colors.yellow)),
        ),
      ),
      onTap: () {
        widget.focusNode.unfocus();
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
        widget.submitAction(widget.textController.text);
      },
    );
  }
}
