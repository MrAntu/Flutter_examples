import 'package:flutter/material.dart';
import 'tools/bus.dart';
import 'events/count_events.dart';
import 'second_screen.dart';
class EventBusFirstPage extends StatefulWidget {
  const EventBusFirstPage({Key key}) : super(key: key);

  @override
  _EventBusFirstPageState createState() => _EventBusFirstPageState();
}

class _EventBusFirstPageState extends State<EventBusFirstPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    behaviorBus.on<CountEvent>().listen((event) {
      print("~~~~~~~~~~~");
      print(event.count);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'First'
        ),
      ),
      body: Center(
        child: StreamBuilder<CountEvent>(
            stream: behaviorBus.on<CountEvent>(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Text('you pushed the button ${snapshot.data.count} times')
                  : Text('waiting for data');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SecondScreen())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
