import 'package:flutter/material.dart';
import 'toast.dart';
import 'empty_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef FutureCustomWidgetBuilder<T> = Widget Function(
    BuildContext context, T data);

class FutureCustomBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final T initialData;

  final FutureCustomWidgetBuilder<T> builder;
  const FutureCustomBuilder(
      {Key key, this.future, this.initialData, @required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        initialData: initialData,
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            Toast.showError(snapshot.error.toString());
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return EmptyWidget(showReload: false);
          }
          return builder(ctx, snapshot.data);
        });
  }
}

class FutureRefreshBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final T initialData;
  final RefreshController controller;
  final FutureCustomWidgetBuilder<T> builder;
  final bool enablePullUp;
  final bool enablePullDown;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  FutureRefreshBuilder({
    Key key,
    this.future,
    this.initialData,
    this.enablePullUp = false,
    this.enablePullDown = true,
    this.onRefresh,
    this.onLoading,
    @required this.builder,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        initialData: initialData,
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            Toast.showError(snapshot.error.toString());
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return EmptyWidget(showReload: false);
          }

          return SmartRefresher(
            controller: controller,
            enablePullUp: enablePullUp,
            enablePullDown: enablePullDown,
            onRefresh: onRefresh,
            onLoading: onLoading,
            child: builder(ctx, snapshot.data),
          );
        });
  }
}
