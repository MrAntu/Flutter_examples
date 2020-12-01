import 'package:flutter/material.dart';
import 'showBottomDialog.dart';
import 'dialog.dart';

class DialogDemo extends StatefulWidget {
  DialogDemo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DialogDemoState createState() => _DialogDemoState();
}

class _DialogDemoState extends State<DialogDemo> {
  final list = [
    "列表1",
    "列表2",
    "列表3",
    "列表4",
    "列表5",
  ];
  Alert alert = Alert();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: InkWell(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "自定义dialog",
                ),
              ),
              RaisedButton(
                elevation: 10,
                child: Text("showAlertDialog"),
                onPressed: () {
                  showAlertDialog(
                      context: context,
                      title: Text("标题"),
                      content: Text("我是内容"),
                      semanticLabel: "AlerDialog扩展",
                      actions: <Widget>[
                        FlatButton(
                          child: Text("确认"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("取消"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                },
              ),
              RaisedButton(
                child: Text("showSimpleListDialog"),
                elevation: 10,
                onPressed: () {
                  showSimpleListDialog(
                      context: context,
                      simpleBuilder: SimpleBuilder(),
                      children: <Widget>[
                        for (var i in list) Text(i),
                      ],
                      onItemCallBack: (index) {
                        print(list[index]);
                      });
                },
              ),
              RaisedButton(
                elevation: 10,
                child: Text(
                  "showLoadingDialog",
                  style: _style(),
                ),
                onPressed: () async {
//                  showLoadingDialog(
//                      context: context,
//                      direction: Direction(
//                          message: "加载中",
//                          orientations: Orientations.Vertical,
//                          width: 100,
//                          height: 100));
//

                  alert.showLoadingDialog(
                      context: context,
                      direction: Direction(
                        message: "加载中",
                        orientations: Orientations.Vertical,
                        height: 100,
                        width: 100,
                      ));

                  await Future.delayed(Duration(seconds: 3));
                  alert.cloaseDialog();
                },
              ),
              RaisedButton(
                  elevation: 10,
                  child: Text(
                    "showBottomDialog",
                    style: _style(),
                  ),
                  onPressed: () {
                    showBottomDialog(
                      context: context,
                      title: Text("标题"),
                      content: Container(child: Text("我是内容")),
                      isScrollControlled: true,
                      backgroundColor: Colors.deepOrange,
                      actions: <Widget>[
                        FlatButton(
                          child: Text("确认"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text("取消"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }),
              RaisedButton(
                child: Text(
                  "showCustomAlertDialog",
                ),
                elevation: 10,
                onPressed: () {
                  showCustomAlertDialog(
                      context: context,
                      dialogBuilder: DialogBuilder(
                        simpleBuilder: SimpleBuilder(
                          title: Text("标题"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                for (var i in list)
                                  InkWell(
                                    child: Text(i),
                                    onTap: () {
                                      print(i);
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      confirmWidget: Text("确认"),
                      cancelWidget: Text("取消"),
                      onConfirmCallBack: () {
                        Navigator.pop(context);
                      },
                      onCancelCallBack: () {
                        Navigator.pop(context);
                      });
                },
              ),
              RaisedButton(
                child: Text(
                  "showCustomSimpleDialog",
                ),
                elevation: 10,
                onPressed: () {
                  showCustomSimpleDialog(
                    context: context,
                    simpleBuilder: SimpleBuilder(),
                    children: <Widget>[Text("自定义CustomDialog")],
                  );
                },
              ),
              RaisedButton(
                onPressed: () {
                  showCustomDialog(
                      context: context,
                      gravity: -0,
                      child: Text("showCustomDialog"));
                },
                child: Text("showCustomDialog"),
                elevation: 10,
              ),
              RaisedButton(
                elevation: 10,
                child: Text(
                  "showTimePickerDialog",
                  style: _style(),
                ),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2018),
                    lastDate: DateTime(2030),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _style() {
    return TextStyle(color: Colors.black);
  }
}
