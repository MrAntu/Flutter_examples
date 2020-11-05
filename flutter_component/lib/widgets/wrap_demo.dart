import 'package:flutter/material.dart';

class WrapDemo extends StatefulWidget {
  const WrapDemo({Key key}) : super(key: key);

  @override
  _WrapDemoState createState() => _WrapDemoState();
}

class _WrapDemoState extends State<WrapDemo> {

  List<Widget> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = List<Widget>()..add(buildAddButton());
  }

  Widget buildAddButton() {
    return GestureDetector(
      onTap: () {
        if (list.length < 9) {
          setState(() {
            list.insert(list.length - 1, buildPhoto());
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.black54,
          child: Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );

  }

  Widget buildPhoto() {

    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.amber,
        child: Center(
          child: Text('照片'),
        ),
      ),
    );
  }


    @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: width,
            height: height / 2,
            color: Colors.grey,
            child: Wrap(
              children: list,
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
