import 'package:flutter/material.dart';

class AnimatedSwitcherRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('9.6 通用“动画切换”组件（AnimatedSwitcher）'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AnimatedSwitcherDemo1Route();
              }));
            },
            child: Text('动画切换-基础—计数器自增效果'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AnimatedSwitcherDemo2Route();
              }));
            },
            child: Text('动画切换-高级-平滑切换效果'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AnimatedSwitcherDemo3Route();
              }));
            },
            child: Text('动画切换-高级-平滑切换组件封装'),
          ),
        ],
      ),
    );
  }
}

class AnimatedSwitcherDemo1Route extends StatefulWidget {
  @override
  _AnimatedSwitcherDemo1RouteState createState() =>
      _AnimatedSwitcherDemo1RouteState();
}

class _AnimatedSwitcherDemo1RouteState
    extends State<AnimatedSwitcherDemo1Route> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画切换-基础-计数器自增效果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              // 新 child 动画执行时长
              duration: const Duration(
                milliseconds: 500,
              ),
              reverseDuration: const Duration(
                milliseconds: 1000,
              ),
              // typedef AnimatedSwitcherTransitionBuilder = Widget Function(Widget child, Animation<double> animation);
              // 切换动画构建器，默认是执行 fade 切换
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              // 对旧child，绑定的动画会反向执行（reverse）,这里对旧 child，执行的是缩小动画。
              // 对新child，绑定的动画会正向指向（forward）,这里对新 child，执行的是放大动画。
              child: Text(
                '$_count',
                // 显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ++_count;
                });
              },
              child: const Text('+1'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedSwitcherDemo2Route extends StatefulWidget {
  @override
  _AnimatedSwitcherDemo2RouteState createState() =>
      _AnimatedSwitcherDemo2RouteState();
}

class _AnimatedSwitcherDemo2RouteState
    extends State<AnimatedSwitcherDemo2Route> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画切换-高级-平滑切换效果'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(
                milliseconds: 500,
              ),
              // typedef AnimatedSwitcherTransitionBuilder = Widget Function(Widget child, Animation<double> animation);
              transitionBuilder: (Widget child, Animation<double> animation) {
                // 正向动画是 child 从右侧屏幕滑入。
                // 反向动画本来是 child 从右侧屏幕滑出，修改后变成从左侧屏幕滑出。
                var tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
                return MySlideTransition(
                  position: tween.animate(animation),
                  child: child,
                );
              },
              child: Text(
                '$_count',
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ++_count;
                });
              },
              child: Text('+1'),
            ),
          ],
        ),
      ),
    );
  }
}

// 修改自 SlideTransition 类，
// 与 SlideTransition 的不同是对动画的反向执行进行了定制（改为从左边划出隐藏）
class MySlideTransition extends AnimatedWidget {
  const MySlideTransition({
    Key key,
    @required Animation<Offset> position,
    this.transformHitTests = true,
    this.textDirection,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position);

  Animation<Offset> get position => listenable as Animation<Offset>;

  final TextDirection textDirection;

  final bool transformHitTests;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Offset offset = position.value;
    // if (textDirection == TextDirection.rtl)
    //   offset = Offset(-offset.dx, offset.dy);
    // 动画反向执行时，调整 x 偏移，实现从左边划出隐藏。
    if (position.status == AnimationStatus.reverse) {
      // 这里改变了动画的 x 起始的偏移点。
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class AnimatedSwitcherDemo3Route extends StatefulWidget {
  @override
  _AnimatedSwitcherDemo3RouteState createState() =>
      _AnimatedSwitcherDemo3RouteState();
}

class _AnimatedSwitcherDemo3RouteState
    extends State<AnimatedSwitcherDemo3Route> {
  int _count = 0;
  var _direction = AxisDirection.left;

  _onDirectionChanged(AxisDirection direction) {
    setState(() {
      _direction = direction;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画切换-高级-平滑切换组件封装'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              // typedef AnimatedSwitcherTransitionBuilder = Widget Function(Widget child, Animation<double> animation);
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SuperSlideTransition(
                  position: animation,
                  child: child,
                  direction: _direction,
                );
              },
              child: Text(
                '$_count',
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    ++_count;
                  });
                },
                child: Text('+1')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("滑入方向"),
                SizedBox(width: 16,),
                DropdownButton(
                  value: _direction,
                  items: <DropdownMenuItem<AxisDirection>>[
                    DropdownMenuItem(
                      child: Text("从左侧滑入"),
                      value: AxisDirection.left,
                    ),
                    DropdownMenuItem(
                      child: Text("从顶部滑入"),
                      value: AxisDirection.up,
                    ),
                    DropdownMenuItem(
                      child: Text("从右侧滑入"),
                      value: AxisDirection.right,
                    ),
                    DropdownMenuItem(
                      child: Text("从底部滑入"),
                      value: AxisDirection.down,
                    ),
                  ],
                  // typedef ValueChanged<T> = void Function(T value);
                  onChanged: _onDirectionChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class SuperSlideTransition extends AnimatedWidget {
  SuperSlideTransition({
    Key key,
    // 不使用传入的动画了
    @required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    this.child,
  })  : assert(position != null),
        super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.left: // 从左侧滑入
        _tween = Tween(begin: Offset(-1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.up: // 从顶部滑入
        _tween = Tween(begin: Offset(0, -1), end: Offset(0, 0));
        break;
      case AxisDirection.right: // 从右侧滑入
        _tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
        break;
      case AxisDirection.down: // 从底部滑入
        _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
        break;
    }
  }

  Animation<double> get position => listenable;

  final AxisDirection direction;

  final bool transformHitTests;

  final Widget child;

  Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    var animate = _tween.animate(listenable);
    Offset offset = animate.value;
    if (position.status == AnimationStatus.reverse) {
      // 修正反向动画的偏移起始点
      switch (direction) {
        case AxisDirection.left: // 从左侧滑入
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.up: // 从顶部滑入
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right: // 从右侧滑入
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down: // 从底部滑入
          offset = Offset(offset.dx, -offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
