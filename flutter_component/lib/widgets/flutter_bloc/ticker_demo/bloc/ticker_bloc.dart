import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../ticker/ticker.dart';
part 'ticker_event.dart';
part 'ticker_state.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final Ticker _ticker;
  StreamSubscription _subscription;

  TickerBloc(this._ticker) : super(TickerInitial());

  @override
  Stream<TickerState> mapEventToState(
    TickerEvent event,
  ) async* {
    if (event is TickerStarted) {
      await _subscription?.cancel();
      _subscription = _ticker.ticker().listen((count) {
        add(_TickerTicked(count));
      });
    }
    if (event is _TickerTicked) {
      yield TickerTickSuccess(event.tickCount);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
