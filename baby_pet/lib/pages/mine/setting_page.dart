import 'package:flutter/material.dart';
import '../../components/alert.dart';
import '../../common/commom_tool.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../components/toast.dart';
import '../../utils/route_util.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: _settingButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 50,
        child: RaisedButton(
            child: Text(
              '退出',
              style: TextStyle(fontSize: 16),
            ),
            textColor: Color(0xFF4b4b4b),
            disabledTextColor: Color(0xFF6F6F6F),
            color: Theme.of(context).primaryColor,
            disabledColor: Color(0xFFffea9e),
            shape: StadiumBorder(),
            onPressed: () {
              Alert.showAlert(
                  context: context,
                  message: '确认退出登录',
                  rightTitle: '确认',
                  rightPressed: () {
                    print('123123');
                    CommonTool.loginOutAction();
                    context.read<UserProviders>().loginOutAction();
                    Toast.showSuccess('退出登录成功');
                    RouteUtil.pop(context);
                  });
            }),
      ),
    );
  }
}
