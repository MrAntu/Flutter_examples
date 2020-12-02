import 'package:flutter/material.dart';

class BottomSheetCorner extends StatelessWidget {
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
    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: new Radius.circular(15.0),
                topRight: new Radius.circular(15.0))),
        builder: (context) => Material(
            // clipBehavior: Clip.antiAlias,
            color: Colors.white,
            // shape: RoundedRectangleBorder(
            //     borderRadius: new BorderRadius.only(
            //         topLeft: new Radius.circular(15.0),
            //         topRight: new Radius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  color: Colors.yellow,
                  height: 100,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: 5,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListTile(
                          title: Text(
                            "Sdfsdf",
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.pushNamed(context, "/${menu.items[i]}");
                          }),
                    ),
                  ),
                ),
                // MyAboutTile()
              ],
            )));
  }
}
