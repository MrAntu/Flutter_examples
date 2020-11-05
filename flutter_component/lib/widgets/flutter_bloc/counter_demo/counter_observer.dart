import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterObserver extends BlocObserver {

  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType} $change');
    // TODO: implement onChange
    super.onChange(cubit, change);

  }
}