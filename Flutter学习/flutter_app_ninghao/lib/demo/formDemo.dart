import 'package:flutter/material.dart';


class FormDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //重新设置主题颜色
      body: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.black
          ),
//          child: ThemeDemo()
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: RegisterFormDemo(),
          ),
        ),
      ),
    );
  }
}


class RegisterFormDemo extends StatefulWidget {
  @override
  _RegisterFormDemoState createState() => _RegisterFormDemoState();
}

class _RegisterFormDemoState extends State<RegisterFormDemo> {
 final _registerFormKey = GlobalKey<FormState>();
 String _username, _password;
 // 是否自动开启表单验证
 bool _autoValidate = false;

 void _submitRegisterForm() {
   if (_registerFormKey.currentState.validate()) {
     _registerFormKey.currentState.save();
     print(_username);
     print(_password);
     _autoValidate = false;
     Scaffold.of(context).showSnackBar(
       SnackBar(
         content: Text("提交成功"),
       )
     );
   } else {
     setState(() {
       _autoValidate = true;
     });
   }

 }

 String _validateUsername(String value) {
   if(value.isEmpty) {
     return "username is empty";
   }
   return null;
 }

 String _validatePassword(String value) {
   if(value.isEmpty) {
     return "password is empty";
   }
   return null;
 }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "username",
            ),
            onSaved: (value) {
              _username = value;
            },
            validator: _validateUsername,
            autovalidate: _autoValidate, //自动开启表单验证
          ),

          TextFormField(
           obscureText: true, //设置加密
            decoration: InputDecoration(
              labelText: "password",
            ),
            onSaved: (value) {
              _password = value;
            },
            validator: _validatePassword,
            autovalidate: _autoValidate,
          ),

          SizedBox(
            height: 32,
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              child: Text("确定"),
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0, //不设置阴影
              onPressed: _submitRegisterForm
            ),
          )
        ],
      ),
    );
  }
}



class TextFiedDemo extends StatefulWidget {
  @override
  _TextFiedDemoState createState() => _TextFiedDemoState();
}

class _TextFiedDemoState extends State<TextFiedDemo> {
  final TextEditingController _textController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController.text = "hi";
    // 监听文字变化
    _textController.addListener(
      () {
          debugPrint("${_textController.text}");
      }
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
//      onChanged: (value) {
//        debugPrint(value);
//      },
      onSubmitted: (value) {
        debugPrint("submit-- ${value}");
      },
      decoration: InputDecoration(
        icon: Icon(Icons.subject),
        labelText: "Title",
        hintText: "please input",
//        border: InputBorder.none, //去掉底部边框
//        border: OutlineInputBorder(), //设置全面边框
        filled: true //设置灰色背景
      ),
    );
  }
}


class ThemeDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
    );
  }
}

