import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../../utils/route_util.dart';
import '../../components/keyboard_dismisser.dart';
import '../../components/auth_code_button.dart';
import '../../components/toast.dart';
import '../../components/text_input.dart';
import '../request/request.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  FocusNode _accountNode = new FocusNode();
  FocusNode _codeNode = new FocusNode();

  final GlobalKey<AuthCodeButtonState> authButtonKey = GlobalKey();

  String _account = '';
  String _code = '';
  bool _disabled = false;

  void _updateLoginState() {
    final isDisable = _account.length >= 3 && _code.length >= 3;
    setState(() {
      _disabled = isDisable;
    });
  }

  @override
  void dispose() {
    _accountController.dispose();
    _codeController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('登录'),
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Image.asset(
                Utils.getImgPath('login_logo'),
                width: double.infinity,
                height: 155,
                fit: BoxFit.cover,
              ),
              Positioned(top: 105, left: 0, child: _loginContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: MediaQuery.of(context).size.height - 200,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                _accountInput(),
                SizedBox(height: 10),
                _authCodeInput(),
                _registerWidget(),
                SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: _loginButton(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 50,
        child: RaisedButton(
          child: Text(
            '登录',
            style: TextStyle(fontSize: 16),
          ),
          textColor: Color(0xFF4b4b4b),
          disabledTextColor: Color(0xFF6F6F6F),
          color: Theme.of(context).primaryColor,
          disabledColor: Color(0xFFffea9e),
          shape: StadiumBorder(),
          onPressed: _disabled
              ? () {
                  _loginAction();
                }
              : null,
        ),
      ),
    );
  }

  Widget _registerWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        child: GestureDetector(
          child: Text(
            '账号密码登录',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onTap: () {
            print('123123');
          },
        ),
      ),
    );
  }

  void _loginAction() {
    if (_account != '123') {
      Toast.showWarn('账号为：123');
      return;
    }
    if (_code != '123') {
      Toast.showWarn('验证码为：123');
      return;
    }
    Toast.showLoading();
    final params = {
      'username': '13456789417',
      'password': 'mmmm0000',
      'type': 'password',
      'token': ''
    };
    Request.getLoginInfo(params).then((value) {
      Toast.dismiss();
      Toast.showSuccess('登录成功');
      context.read<UserProviders>().setLoginInfo(value);
      Navigator.of(context).pop();
    }).catchError((err) {
      Toast.dismiss();
      Toast.showError(err.toString());
    });
  }

  Widget _accountInput() {
    return TextInput(
      leftTitle: '手机号',
      hintText: '请输入手机号',
      autofocus: true,
      controller: _accountController,
      focusNode: _accountNode,
      keyboardType: TextInputType.number,
      maxLength: 11,
      onChanged: (text) {
        _account = text;
        _updateLoginState();
        print(text);
      },
    );
  }

  Widget _authCodeInput() {
    return TextInput(
      leftTitle: '验证码',
      hintText: '请输入验证码',
      controller: _codeController,
      focusNode: _codeNode,
      keyboardType: TextInputType.number,
      maxLength: 6,
      suffix: _codeButton(),
      onChanged: (text) {
        _code = text;
        _updateLoginState();
        print(text);
      },
    );
  }

  Widget _codeButton() {
    return AuthCodeButton(
        key: authButtonKey,
        timeCount: 60,
        onPressed: () {
          if (_account.length < 11) {
            Toast.showWarn('请输入正确手机号');
            return;
          }
          _getCodeAction();
        });
  }

  _getCodeAction() {
    Toast.showSuccess('验证码已发送');
    authButtonKey.currentState.starTimer();
  }
}
