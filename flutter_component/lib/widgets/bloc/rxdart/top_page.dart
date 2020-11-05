import 'package:flutter/material.dart';
import 'blocs/CountBlocImpl.dart';
import 'blocs/count_bloc.dart';
class TopPageDemo extends StatefulWidget {
  const TopPageDemo({Key key}) : super(key: key);

  @override
  _TopPageDemoState createState() => _TopPageDemoState();
}

class _TopPageDemoState extends State<TopPageDemo> {
  final bloc = CountBlocImpl();

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
            return UnderPage(bloc: bloc,);
          }));
        },
      ),
    );
  }
}


class UnderPage extends StatelessWidget {
  final CountBloc bloc;
  const UnderPage({Key key, this.bloc}) : super(key: key);

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
