import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StateManagerDemo extends StatefulWidget {
  @override
  _StateManagerDemoState createState() => _StateManagerDemoState();
}

class _StateManagerDemoState extends State<StateManagerDemo> {
  int _count = 0;

  void _increaseCount() {
    setState(() {
      _count += 1;
    });
    print(_count);
  }
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
        count: _count,
        increaseCount: _increaseCount,
        child: Scaffold(
          appBar: AppBar(
            title: Text("StateManagerDemo"),
          ),
          body: CounterDemo(),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _increaseCount
          ),
        ),
    );
  }
}


class CounterDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CounterWrapper()
    );
  }
}


class CounterWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int count = CounterProvider.of(context).count;
    final VoidCallback increaseCount = CounterProvider.of(context).increaseCount;
    return ActionChip(
        label: Text("$count"),
        elevation: 0,
        pressElevation: 0,
        onPressed: increaseCount
    );
  }
}

class CounterProvider extends InheritedWidget {
  final int count;
  final VoidCallback increaseCount;

  const CounterProvider({
    Key key,
    @required Widget child,
    this.count,
    this.increaseCount
  })
      : assert(child != null),
        super(key: key, child: child);

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(CounterProvider old) {
    return true;
  }
}

class CounterModel extends Model {

}

