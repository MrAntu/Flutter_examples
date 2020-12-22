import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumeProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final bool autoDispose;
  final ValueWidgetBuilder<T> builder;
  final Function(T model) onModelReady;

  const ConsumeProviderWidget(
      {Key key,
      @required this.model,
      @required this.builder,
      this.child,
      this.onModelReady,
      this.autoDispose = true})
      : super(key: key);

  @override
  _ConsumeProviderWidgetState<T> createState() =>
      _ConsumeProviderWidgetState<T>();
}

class _ConsumeProviderWidgetState<T extends ChangeNotifier>
    extends State<ConsumeProviderWidget<T>> {
  T model;
  @override
  void initState() {
    super.initState();
    model = widget.model;
    widget.onModelReady?.call(model);
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
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
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
