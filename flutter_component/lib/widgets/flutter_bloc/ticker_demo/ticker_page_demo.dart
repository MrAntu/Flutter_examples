import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/ticker_bloc.dart';
import 'ticker/ticker.dart';

class TickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TickerBloc(Ticker()),
      child: TickerPageDemo(),
    );
  }
}

class TickerPageDemo extends StatelessWidget {
  const TickerPageDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc with Streams'),
      ),
      body: BlocBuilder<TickerBloc, TickerState>(
        builder: (context, state) {
          if (state is TickerTickSuccess) {
            return Center(
              child: Text('TIck #${state.count}'),
            );
          }
          return Center(
            child: Text('Press the Floatint button to start'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.bloc<TickerBloc>().add(TickerStarted());
        },
        tooltip: 'Start',
        child: const Icon(Icons.timer),
      ),
    );
  }
}
