import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/view_state_provider.dart';
import '../exports.dart';

typedef WidgetProviderBuilder<T extends ChangeNotifier> = Widget Function(
    BuildContext context, T model);

class ConsumeProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final bool autoDispose;
  final ValueWidgetBuilder builder;
  // final Function(T model) onModelReady;
  final WidgetProviderBuilder onLoadingWidget;
  final WidgetProviderBuilder onErrorWidget;
  final ValueChanged onReady;
  const ConsumeProviderWidget({
    Key key,
    @required this.model,
    @required this.builder,
    this.child,
    this.onReady,
    this.autoDispose = true,
    this.onLoadingWidget,
    this.onErrorWidget,
  }) : super(key: key);

  @override
  _ConsumeProviderWidgetState createState() => _ConsumeProviderWidgetState();
}

class _ConsumeProviderWidgetState<T extends ChangeNotifier>
    extends State<ConsumeProviderWidget> {
  T model;
  @override
  void initState() {
    super.initState();
    model = widget.model;
    if (widget.onReady != null) {
      widget.onReady(widget.model);
    }
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      print("object1");
      model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        child: widget.child,
        // builder: widget.builder,
        builder: (context, model, child) {
          if (model is ViewStateProvider) {
            print('123132');
            // 加载中
            if (model.viewState == ViewState.busy) {
              if (widget.onLoadingWidget != null) {
                return widget.onLoadingWidget(context, model);
              }
              // 默认
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // 加载错误
            if (model.viewState == ViewState.error) {
              Toast.showError(model.viewStateError.toString());
              if (widget.onErrorWidget != null) {
                return widget.onErrorWidget(context, model);
              }
              // 默认
              return EmptyWidget(showReload: false);
            }
          }

          return widget.builder(context, model, child);
        },
      ),
    );
  }
}

class ConsumerProviderWidget2<A extends ChangeNotifier,
    B extends ChangeNotifier> extends StatefulWidget {
  final A model1;
  final B model2;
  final Widget child;
  final bool autoDispose;
  final Function(A model1, B model2) onModelReady;
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;

  ConsumerProviderWidget2({
    Key key,
    @required this.model1,
    @required this.model2,
    @required this.builder,
    this.child,
    this.autoDispose = true,
    this.onModelReady,
  }) : super(key: key);

  @override
  _ConsumerProviderWidgetState2<A, B> createState() =>
      _ConsumerProviderWidgetState2<A, B>();
}

class _ConsumerProviderWidgetState2<A extends ChangeNotifier,
    B extends ChangeNotifier> extends State<ConsumerProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);

    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model1.dispose();
      model2.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      child: Consumer2(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class SelectorProvider<A extends ChangeNotifier, S> extends StatefulWidget {
  final A model;
  final Widget child;
  final bool autoDispose;
  final Function(A model) onModelReady;
  final ValueWidgetBuilder<S> builder;
  final S Function(BuildContext, A) selector;

  SelectorProvider({
    Key key,
    @required this.model,
    @required this.builder,
    this.selector,
    this.child,
    this.onModelReady,
    this.autoDispose,
  }) : super(key: key);

  @override
  _SelectorProviderState<A> createState() => _SelectorProviderState<A>();
}

class _SelectorProviderState<A extends ChangeNotifier>
    extends State<SelectorProvider<A, A>> {
  A model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady?.call(model);

    super.initState();
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      model.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<A>.value(
      value: model,
      child: Selector<A, A>(
        builder: widget.builder,
        selector: widget.selector,
        child: widget.child,
      ),
    );
  }
}
