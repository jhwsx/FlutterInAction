import 'package:flutter/material.dart';

// Theme, MediaQuery 也是这种机制
/// When using the `of` method, the `context` must be a descendant of the
/// [InheritedWidget], meaning it must be "below" the [InheritedWidget] in the
/// tree.
/// InheritedWidget 的作用是什么？
/// 在应用的根 widget 中通过 InheritedWidget 共享了一个数据，那么我们便可以在任意子 widget
/// 中来获取该共享的数据。
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
      // count;
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
        child: Column(
          children: <Widget>[
            SharedDataWidget(
              data: count,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 正确的写法：
                  TestWidget(), // 子 widget 有依赖 SharedDataWidget。
                  // 正确的写法:
                  // Builder(builder: (BuildContext context) {
                  //   return Text(
                  //     SharedDataWidget.of(context).data.toString(),
                  //     style: TextStyle(color: Colors.green),
                  //   );
                  // }),
                  // 错误的用法：传入的 context 并不是 InheritedWidget 的子类。
                  // Text(
                  //   SharedDataWidget.of(context).data.toString(),
                  //   style: TextStyle(color: Colors.red),
                  // ),
                  ElevatedButton(
                    child: Text('Increment'),
                    onPressed: _incrementCount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharedDataWidget extends InheritedWidget {
  SharedDataWidget({Key key, @required this.data, Widget child})
      : super(key: key, child: child);
  final int data; // 需要在子树中共享的数据，就是点击次数。
  /// 这个方法的作用是方便子树的 widget 获取共享数据，它会注册依赖关系。
  static SharedDataWidget of(BuildContext context) {
    /// 此方法定义在 BuildContext 中，但是它的实现是在 Element 中。
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
  }

  /// 这个方法的作用是获取 SharedDataWidget 的数据，但在 SharedDataWidget 数据发生变化时
  /// 不会调用子或孙 widget 的 didChangeDependencies() 方法。它不会注册依赖关系。
  static SharedDataWidget of2(BuildContext context) {
    /// 此方法定义在 BuildContext 中，但是它的实现是在 Element 中。
    return context
        .getElementForInheritedWidgetOfExactType<SharedDataWidget>()
        .widget;
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
    print('_TestWidgetState build() called');
    // 如果不使用 InheritedWidget 中的共享数据，那么当点击按钮时，didChangeDependencies 不会回调。
    // return Text("text");
    return Text(SharedDataWidget.of(context).data.toString());
    // return Text(SharedDataWidget.of2(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先 widget 中的 InheritedWidget 改变（updateShouldNotify 返回 true）时
    // 会被调用。如果 build 方法中没有依赖 InheritedWidget，则此回调不会被调用。
    print(
        '_TestWidgetState didChangeDependencies() called, because dependencies changed.');
  }
}
