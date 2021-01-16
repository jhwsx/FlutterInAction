import 'package:flutter/material.dart';

class CompositeExamplesRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10.3 组合实例"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return TurnBoxRoute();
              }));
            },
            child: Text('TurnBox'),
          ),
        ],
      ),
    );
  }
}

class TurnBoxRoute extends StatefulWidget {
  @override
  _TurnBoxRouteState createState() => _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TurnBox'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TurnBox(
              child: Icon(
                Icons.refresh,
                size: 100.0,
                color: Colors.blue,
              ),
              turns: _turns,
              duration: 500,
            ),
            TurnBox(
              child: Icon(
                Icons.refresh,
                size: 150.0,
                color: Colors.green,
              ),
              turns: _turns,
              duration: 1000,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns += 0.2;
                });
              },
              child: Text("顺时针转 1/5 圈"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _turns -= 0.2;
                });
              },
              child: Text("逆时针转 1/5 圈"),
            ),
          ],
        ),
      ),
    );
  }
}

// 实现一个TurnBox组件，它不仅可以以任意角度来旋转其子节点，而且可以在角度发生变化时执行
// 一个动画以过渡到新状态，同时，我们可以手动指定动画速度。
class TurnBox extends StatefulWidget {
  const TurnBox(
      {Key key,
      this.turns = 0.0, // 旋转的圈数，1.0 代表一圈，0.25 代表四分之一圈。
      this.duration = 200, // 过渡动画执行的总时长
      @required this.child})
      : super(key: key);

  final double turns;

  final int duration;
  final Widget child;

  @override
  _TurnBoxState createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    print('initState()');
    _controller = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _controller.value = widget.turns;
    super.initState();
  }

  @override
  void dispose() {
    print('dispose()');
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build()');
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  // 当 widget 的配置发生改变时调用此方法
  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    print('didUpdateWidget()');
    // 旋转角度发生时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(widget.turns,
          duration: Duration(
            milliseconds: widget.duration ?? 200,
          ),
          curve: Curves.easeOut);
    }
    super.didUpdateWidget(oldWidget);
  }
}
