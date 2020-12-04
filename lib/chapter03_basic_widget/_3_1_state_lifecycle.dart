import 'package:flutter/material.dart';

class StateLifecycleRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State 生命周期',
      debugShowCheckedModeBanner: false,
      home: CountWidget(),
    );
  }

}


class CountWidget extends StatefulWidget {
  // 计数器的初始值
  final int initValue;

  const CountWidget({Key key, this.initValue = 0});

  @override
  State<StatefulWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  // 状态值
  int _counter;

  // 当 StatefulWidget 插入到 Widget 树时调用该方法
  // Framework 会为每一个它创建的 State 对象调用这个方法, 仅仅一次.
  // 通常在这里做一些一次性的操作.
  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print('initState');
  }

  // 用于构建 Widget 子树的
  // Framework 在几种不同的情况下会调用此方法:
  // * 在调用 initState 之后
  // * 在调用 didUpdateWidget 之后
  // * 在收到对 setState 的一个调用之后
  // * 在 State 对象的依赖改变之后
  // * After calling [deactivate] and then reinserting the [State] object into
  //   the tree at another location.
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('State 生命周期'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                setState(() {
                  ++_counter;
                });
              },
              child: Text('$_counter'),
            ),
          ],
        ),
      ),
    );
  }

  // 当 widget 的配置发生改变时调用此方法
  // 覆写这个方法,确保要开始就调用 super.didUpdateWidget(oldWidget);
  // ：在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中
  // 同一位置的新旧节点，然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。
  @override
  void didUpdateWidget(CountWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  // 当 State 对象被从树上移除的时候调用此方法
  // 覆写此方法,确保最后调用 super.deactivate();
  // 如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  // 当 State 对象被永久从树上移除时调用此方法
  // 覆写此方法,确保最后调用 super.dispose();
  // 通常在这里释放资源.
  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  // 此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，
  // 此回调在Release模式下永远不会被调用。
  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  // 当 State 对象的依赖发生改变时调用此方法
  // 此方法在调用 initState 后会马上被调用
  // 典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}