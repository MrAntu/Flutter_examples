import 'package:flutter/material.dart';

class BottomSheetDemo extends StatelessWidget {
  const BottomSheetDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            _openBottomSheet(context);
          },
          child: Text(
            'bottom sheet',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet<String>(
        context: context,
        builder: (ctx) {
          return SafeArea(
            child: Container(
//            height: 500,
//            alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: Wrap(
                children: [
                  _getListTile(Icons.more, Colors.black45, "More", context),
                  _getListTile(
                      Icons.favorite, Colors.pink, "Favorites", context),
                  _getListTile(
                      Icons.account_box, Colors.blue, "Profile", context),
                  _getListTile(Icons.more, Colors.black45, "More", context),
                  _getListTile(
                      Icons.favorite, Colors.pink, "Favorites", context),
                  _getListTile(
                      Icons.account_box, Colors.blue, "Profile", context),
                  _getListTile(Icons.more, Colors.black45, "More", context),
                  _getListTile(
                      Icons.favorite, Colors.pink, "Favorites", context),
                  _getListTile(
                      Icons.account_box, Colors.blue, "Profile", context),
                  _getListTile(Icons.more, Colors.black45, "More", context),
                  _getListTile(
                      Icons.favorite, Colors.pink, "Favorites", context),
                  _getListTile(
                      Icons.account_box, Colors.blue, "Profile", context),
                ],
              ),
            ),
          );
        }).then((value) {
      print(value);
    });
  }

  ListTile _getListTile(icon, iconColor, titleText, context) {
    return ListTile(
      leading: Container(
        width: 4,
        child: Icon(
          icon,
          color: iconColor,
          size: 24,
        ),
      ),
      title: Text(
        titleText,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
      onTap: () {
        Navigator.of(context).pop('sdfsdf');
      },
    );
  }
}
