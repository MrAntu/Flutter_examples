import 'package:flutter/material.dart';
import 'bloc_counter_demo.dart';
class BlocDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocCounterProvider(
      bloc: CountBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bloc"),
        ),
        body: BlocCounterDemo(),
        floatingActionButton: BlocCounterFloatBtn(),
      ),
    );
  }
}
