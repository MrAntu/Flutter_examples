import 'package:flutter/material.dart';


/**
 * 在多个TextField中获取焦点，并通过键盘跳到下一个焦点的demo

 * 实现原理：
 * 使用FocusNode获取当前textField焦点
 * 在TextNode的textInputAction属性中选择键盘action（next/down）
 * 对于最后一个之前的TextField：在onSubmitted属性中解除当前focus状态
 * 再聚焦下一个FocusNode:FocusScope.of(context).requestFocus( nextFocusNode );
 * 对于最后一个TextField,直接解除focus并提交表单
 */


class TextFieldFocusDemo extends StatefulWidget {
  const TextFieldFocusDemo({Key key}) : super(key: key);

  @override
  _TextFieldFocusDemoState createState() => _TextFieldFocusDemoState();
}

class _TextFieldFocusDemoState extends State<TextFieldFocusDemo> {
  TextEditingController _nameController,_pwController;
  FocusNode _nameFocus,_pwFocus;

  @override
  void initState() {
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    _nameFocus = FocusNode();
    _pwFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pwController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // 点击空白出隐藏键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              SizedBox(height: 80,),
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              SizedBox(height: 380,),

              Padding(
                padding: EdgeInsets.all(16),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    focusNode: _nameFocus,
                    obscureText: false,
                    controller: _nameController,
                    // 修改键盘的右下角回车键样式
                    textInputAction: TextInputAction.next,
                    onSubmitted: (input) {
                      _nameFocus.unfocus();
                      FocusScope.of(context).requestFocus(_pwFocus);
                    },
                    decoration: InputDecoration(
                        labelText: 'name'
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    focusNode: _pwFocus,
                    obscureText: true,
                    controller: _pwController,
                    onSubmitted: (input) {
                      _pwFocus.unfocus();

                    },
                    decoration: InputDecoration(
                        labelText: 'password'
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              ButtonBar(
                children: [
                  RaisedButton(onPressed: (){}, child: Text('login'),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
