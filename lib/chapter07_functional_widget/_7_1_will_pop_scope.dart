import 'package:flutter/material.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  _WillPopScopeTestRouteState createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("7.1 导航返回拦截（WillPopScope）"),
      ),
      body: Builder(builder: (context) {
        return WillPopScope(
          child: Container(
            alignment: Alignment.center,
            child: Text("1秒内连续两次点击返回键退出"),
          ),
          // 为什么 onWillPop 后面的函数要加上 async 呢？
          // 看一下 onWillPop 的函数类型：typedef WillPopCallback = Future<bool> Function();
          // onWillPop 是一个回调函数，当用户点击返回按钮时调用（包括导航返回按钮及Android物理返回按钮）。
          // 该回调需要返回一个Future对象，如果返回的Future最终值为false时，则当前路由不出栈(不会返回)；
          // 最终值为true时，当前路由出栈退出。我们需要提供这个回调来决定是否退出。
          onWillPop: () async {
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) >
                    Duration(seconds: 1)) {
              _lastPressedAt = DateTime.now();
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("再按一次退出应用")));
              return false;
            }
            return true;
          },
        );
      }),
    );
  }
}
