import 'package:flutter/material.dart';

// TODO Builder 是什么作用?
// https://stackoverflow.com/questions/52088889/can-someone-explain-to-me-what-the-builder-class-does-in-flutter

class FetchStateRoute extends StatelessWidget {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('context1=$context');
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: Text('子树中获取 State 对象')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              // 如果没有 Builder, 那么 _scaffoldState 就是 null.
              return RaisedButton(
                onPressed: () {
                  // 查找父级最近的Scaffold对应的ScaffoldState对象
                  // 查找父级最近的 StatefulWidget 的类型为 ScaffoldState 的 State 对象
                  ScaffoldState _scaffoldState =
                      context.findAncestorStateOfType<ScaffoldState>();
                  // 调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
                  _scaffoldState.showSnackBar(
                      SnackBar(content: Text('我是 SnackBar 的内容 1')));
                },
                child: Text('显示 SnackBar 1'),
              );
            }),
            Builder(builder: (context) {
              // 如果没有 Builder, 那么 _scaffoldState 就是 null.
              print('context2=$context');
              return RaisedButton(
                onPressed: () {
                  // 直接通过of静态方法来获取ScaffoldState
                  ScaffoldState _scaffoldState = Scaffold.of(context);
                  print('context3=$context');
                  // 调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
                  _scaffoldState.showSnackBar(
                      SnackBar(content: Text('我是 SnackBar 的内容 2')));
                },
                child: Text('显示 SnackBar 2'),
              );
            }),
            RaisedButton(
              onPressed: () {
                //_globalKey.currentWidget;
                // 通过 GlobalKey 来获取 State 对象:
                ScaffoldState _scaffoldState = _globalKey.currentState;
                // 调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
                _scaffoldState
                    .showSnackBar(SnackBar(content: Text('我是 SnackBar 的内容 3')));
              },
              child: Text('显示 SnackBar 3'),
            ),
          ],
        ),
      ),
    );
  }
}
