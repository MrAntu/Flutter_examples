import 'package:flutter/material.dart';
import '../common/strings.dart';
import '../models/models.dart';
import '../tools/shared_preferences_util.dart';
import '../common/common.dart';
import '../tools/object_util.dart';
import '../tools/custom_intl/custom_intl.dart';
import 'package:provider/provider.dart';
import '../provider/application_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<LanguageModel> _list = new List();
  LanguageModel _currentLanguage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list.add(LanguageModel(Ids.languageAuto, '', ''));
    _list.add(LanguageModel(Ids.languageZH, 'zh', 'CH'));
    _list.add(LanguageModel(Ids.languageTW, 'zh', 'TW'));
    _list.add(LanguageModel(Ids.languageHK, 'zh', 'HK'));
    _list.add(LanguageModel(Ids.languageEN, 'en', 'US'));

    SharedPreferencesUtil.getObj(
        Constant.keyLanguage, (v) => LanguageModel.fromJson(v)).then((value) {
      _currentLanguage = value;
      if (ObjectUtil.isEmpty(_currentLanguage)) {
        _currentLanguage = _list[0];
      }
      _updateData();
      if (mounted) {
        setState(() {});
      }
    });
  }

  _updateData() {
    String language = _currentLanguage.countryCode;
    int length = _list?.length ?? 0;
    for (int i = 0; i < length; i++) {
      _list[i].isSelected = (_list[i].countryCode == language);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Ids.titleLanguage,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              width: 64,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.indigoAccent,
                child: Text(
                  Ids.save,
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  SharedPreferencesUtil.putObject(
                      Constant.keyLanguage,
                      ObjectUtil.isEmpty(_currentLanguage.languageCode)
                          ? null
                          : _currentLanguage);
                  context
                      .read<ApplicationProvider>()
                      .sendEvent(Constant.type_sys_update);
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _list?.length ?? 0,
        itemBuilder: (context, index) {
          LanguageModel model = _list[index];
          return ListTile(
            title: Text(
              _list[index].titleId,
              style: TextStyle(fontSize: 13),
            ),
            trailing: Radio(
              value: true,
              groupValue: model.isSelected == true,
              activeColor: Colors.indigoAccent,
            ),
            onTap: () {
              setState(() {
                _currentLanguage = model;
                _updateData();
              });
            },
          );
        },
      ),
    );
  }
}
