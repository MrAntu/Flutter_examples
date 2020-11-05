import 'package:flutter/material.dart';
import '../common/strings.dart';
import 'setting_page.dart';

class MainLeftPage extends StatelessWidget {
  const MainLeftPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 166.0,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(Ids.titleSetting),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
