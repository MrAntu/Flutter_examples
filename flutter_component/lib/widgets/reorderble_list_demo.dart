import 'package:flutter/material.dart';

class ReorderbleListDemo extends StatefulWidget {
  const ReorderbleListDemo({Key key}) : super(key: key);

  @override
  _ReorderbleListDemoState createState() => _ReorderbleListDemoState();
}

class _ReorderbleListDemoState extends State<ReorderbleListDemo> {
  List<String> names = [
    "LeBron James",
    "Kevin Durant",
    "Anthony Davis",
    "James Harden",
    "Stephen Curry",
    "Giannis Antetokounmopo",
    "Joel Embiid",
    "Russell Westbrook",
    "Paul George",
    "Kawhi Leonard",
    "Jeremy Shuhow Lin"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        header: AppBar(
          title: Text('Demo'),
        ),
        onReorder: _onReorder,
        children: names.map((e){
          return SizedBox(
            key: ObjectKey(e),
            height: 200,
            child: Card(
              color: Colors.lightBlueAccent.withOpacity(0.4),
              child: Center(
                child: Text(
                  '$e',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white
                  ),

                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex = newIndex - 1;
    }
    var name = names.removeAt(oldIndex);
    names.insert(newIndex, name);
    setState(() {

    });
  }
}
