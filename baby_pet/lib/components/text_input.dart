import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String leftTitle;
  final String hintText;
  final int maxLength;
  final bool autofocus;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Widget suffix;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  const TextInput(
      {Key key,
      this.leftTitle,
      this.hintText,
      this.autofocus = false,
      this.maxLength,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.suffix,
      this.onChanged,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
        child: Row(
          children: [
            Text(
              leftTitle,
              style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.red,
                focusNode: focusNode,
                controller: controller,
                maxLength: maxLength,
                maxLines: 1,
                autofocus: autofocus,
                style: TextStyle(fontSize: 18, color: Color(0xFF333333)),
                onChanged: (text) {
                  onChanged(text);
                },
                onSubmitted: (text) {
                  onSubmitted(text);
                  focusNode.unfocus();
                },
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFFCCCCCC)),
                  counterText: '',
                  fillColor: Colors.transparent,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.none, color: Colors.transparent)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.none, color: Colors.transparent)),
                  suffixIcon: suffix,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
