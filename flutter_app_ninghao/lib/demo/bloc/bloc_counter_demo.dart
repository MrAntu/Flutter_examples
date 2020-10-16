import 'package:flutter/material.dart';
import 'dart:async';
class BlocCounterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountBloc bloc = BlocCounterProvider.of(context).bloc;
    return Center(
      child: StreamBuilder(
        initialData: 0,
        stream: bloc.outputStrem,
        builder: (context, snapshot) {
          return Center(
            child: ActionChip(
                label: Text("${snapshot.data}"),
                onPressed: () {
                  bloc.sink.add(1);
                }
            ),
          );
        },
      )
    );
  }
}

class BlocCounterFloatBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountBloc bloc = BlocCounterProvider.of(context).bloc;

    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        bloc.log();
        bloc.sink.add(1);
      },
    );
  }
}

class BlocCounterProvider extends InheritedWidget {
  final CountBloc bloc;
  const BlocCounterProvider({
    Key key,
    @required Widget child,
    this.bloc
  })
      : assert(child != null),
        super(key: key, child: child);

  static BlocCounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocCounterProvider>();
  }

  @override
  bool updateShouldNotify(BlocCounterProvider old) {
    return true;
  }
}

class CountBloc {
  int _count = 0; //记录增加的总数
  // 接受点击方法的stream
  final _streamController = StreamController<int>();
  StreamSink<int> get sink => _streamController.sink;

  //输出的stream
  final _outputController = StreamController<int>();
  Stream<int> get outputStrem => _outputController.stream;

  //构造方法
  CountBloc() {
    _streamController.stream.listen(onData);
  }

  void dispose() {
    _streamController.close();
    _outputController.close();
  }

  void onData(int data) {
    _count += data;
    print(data);
    _outputController.add(_count);
  }

  void log() {
    print("CountBloc");
  }
}

