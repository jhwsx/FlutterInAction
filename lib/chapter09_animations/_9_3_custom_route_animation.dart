import 'package:flutter/material.dart';

class CustomRouteAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('9.3 自定义路由切换动画'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // PageRouteBuilder 派生自 PageRoute
              Navigator.of(context).push(PageRouteBuilder(
                // typedef RoutePageBuilder = Widget Function(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);
                // animation 是哪里来的呢？是由 Flutter 路由管理器提供的。
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return PageB();
                },
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: Duration(seconds: 5),
              ));
            },
            child: Text('自定义路由切换动画-使用 PageRouteBuilder'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(FadeRoute(builder: (BuildContext context) {
                return PageB();
              }));
            },
            child: Text('自定义路由切换动画-直接继承 PageRoute 类'),
          ),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 3000),
  });

  WidgetBuilder builder;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  // 这里的 child 就是 buildPage 的返回值。
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (isActive) {
      // 当前路由被激活，是打开新路由。
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    } else {
      // 是返回，不适用过渡动画
      return Padding(padding: EdgeInsets.zero);
    }
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("一个新的页面"),
      ),
    );
  }
}
