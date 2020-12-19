import 'package:flutter/material.dart';

class InheritedWidgetRoute extends StatefulWidget {
  @override
  _InheritedWidgetRouteState createState() => _InheritedWidgetRouteState();
}

class _InheritedWidgetRouteState extends State<InheritedWidgetRoute> {
  int count = 0;
  // 每点击一次，count 会自增，然后重新 build，SharedDataWidget 中的 data 会更新，
  // 接着会调用 TestWidget 的 didChangeDependencies 方法，发生更新。
  _incrementCount() {
    setState(() {
      ++count;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7.2 数据共享（InheritedWidget）'),
      ),
      body: Center(
        child: SharedDataWidget(data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TestWidget(), // 子 widget 有依赖 SharedDataWidget。
            ),
            RaisedButton(
              child: Text('Increment'),
              onPressed: _incrementCount,
            ),
          ],
        ),),
      ),
    );
  }
}

class SharedDataWidget extends InheritedWidget {
  SharedDataWidget({@required this.data, Widget child}) : super(child: child);
  final int data; // 需要在子树中共享的数据，就是点击次数。
  /// 这个方法的作用是方便子树的 widget 获取共享数据
  static SharedDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
  }

  // 该回调决定当 data 发生变化时，是否通知子树中依赖 data 的 widget
  @override
  bool updateShouldNotify(covariant SharedDataWidget oldWidget) {
    // 如果返回 true，那么子树中依赖（build 函数中有调用）本 widget 的子 widget
    // 的 `state.didChangDependencies` 会被调用
    return oldWidget.data != data;
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(SharedDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先 widget 中的 InheritedWidget 改变（updateShouldNotify 返回 true）时
    // 会被调用。如果 build 中没有依赖 InheritedWidget，则此回调不会被调用。
    print('didChangeDependencies() called, because dependencies changed.');
  }
}
