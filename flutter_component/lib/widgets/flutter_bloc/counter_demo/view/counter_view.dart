import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../counter.dart';
class CounterView extends StatelessWidget {
  const CounterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('counter'),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text('$state', style: Theme.of(context).textTheme.bodyText1,);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.bloc<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
            key: const Key('add'),
          ),

          FloatingActionButton(
            onPressed: () {
              context.bloc<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
            key: const Key('remove'),
          ),
        ],
      ),
    );
  }
}
