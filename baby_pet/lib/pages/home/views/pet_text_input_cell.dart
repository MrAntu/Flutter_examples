import 'package:flutter/material.dart';
import '../../../exports.dart';

class PetTextInputCell extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String leftTitle;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String placeholder;

  PetTextInputCell({
    Key key,
    this.onChanged,
    this.leftTitle,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 16),
          _topWidget(),
          SizedBox(height: 15.5),
          _bottomLine(),
        ],
      ),
    );
  }

  Widget _topWidget() {
    return Container(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftTitle,
            style: TextStyle(fontSize: 14),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    controller: controller,
                    keyboardType: keyboardType,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    onChanged: (text) => onChanged(text),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      hintText: placeholder,
                      fillColor: Colors.transparent,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              color: Colors.transparent)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.none,
                              color: Colors.transparent)),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                // 箭头
                Icon(Icons.keyboard_arrow_right, size: 28),
                SizedBox(width: 6),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomLine() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
//          color: Colors.black,
          color: Color(0xFFe8e8e8),
          height: 0.5,
        ),
      ),
    );
  }
}
