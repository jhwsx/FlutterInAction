import 'dart:async';

import 'package:flutter/material.dart';

class BLoCWidget extends StatefulWidget {
  @override
  _BLoCWidgetState createState() => _BLoCWidgetState();
}

class _BLoCWidgetState extends State<BLoCWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncrementBloc>(
      bloc: IncrementBloc(),
      child: CounterPage(),
    );
  }
}

abstract class BlocBase {
  /// 用于资源的释放
  void dispose();
}

/// 一个标准的 BLoC 类通常包含：
/// 私有的 model 和 StreamController
/// 公开的 get 方法返回 Stream
/// 公开的业务处理函数
/// dispose 函数

class IncrementBloc implements BlocBase {
  // 私有化控制访问权限
  int _count;

  StreamController<int> _countController;

  IncrementBloc() {
    _count = 0;
    _countController = StreamController<int>();
  }

  // 暴露给外部的 Stream
  Stream<int> get value => _countController.stream;

  // 暴露给外部的 increment 函数
  increment() {
    _countController.sink.add(++_count);
  }

  @override
  void dispose() {
    _countController.close();
  }
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    // 在 Widget 树中向上查找最近的父级 BlocProvider Widget.
    BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.value,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text('You hit me ${snapshot.data} times');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => bloc.increment(),
      ),
    );
  }
}
