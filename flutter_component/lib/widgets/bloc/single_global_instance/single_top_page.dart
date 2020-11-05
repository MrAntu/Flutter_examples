import 'package:flutter/material.dart';
import 'count_bloc.dart';
class SingleTopPageDemo extends StatefulWidget {
  const SingleTopPageDemo({Key key}) : super(key: key);

  @override
  _SingleTopPageDemoState createState() => _SingleTopPageDemoState();
}

class _SingleTopPageDemoState extends State<SingleTopPageDemo> {

  @override
  void dispose() {
    bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('top page'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.stream,
          initialData: bloc.value,
          builder: (context, snapshot) {
            return Text(
              'You hit me: ${snapshot.data} times',
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return UnderPage();
          }));
        },
      ),
    );
  }
}


class UnderPage extends StatelessWidget {
  const UnderPage({Key key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('under page'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream,
          initialData: bloc.value,
          builder: (context, snapshot) {
            return Text(
              "You hit me: ${snapshot.data} times",
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
