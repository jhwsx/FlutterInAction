import 'package:flutter/material.dart';

// 动画过渡组件的明显特征是它会在内部管理 AnimationController。
class AnimationTransitionRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('9.7 动画过渡组件'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return AnimationTransitionCustomRoute();
              }));
            },
            child: Text("动画过渡组件-自定义"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return AnimationTransitionFlutterRoute();
              }));
            },
            child: Text("动画过渡组件-Flutter 封装的组件"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return AnimationTransitionFlutterWidgetRoute();
              }));
            },
            child: Text("动画过渡组件-Flutter 预置的组件"),
          ),
        ],
      ),
    );
  }
}

class AnimationTransitionCustomRoute extends StatefulWidget {
  @override
  _AnimationTransitionCustomRouteState createState() =>
      _AnimationTransitionCustomRouteState();
}

class _AnimationTransitionCustomRouteState
    extends State<AnimationTransitionCustomRoute> {
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画过渡组件-自定义"),
      ),
      body: Center(
        child: AnimatedDecorationBox(
          decoration: BoxDecoration(color: _decorationColor),
          duration: duration,
          child: TextButton(
            onPressed: () {
              setState(() {
                if (_decorationColor == Colors.blue) {
                  _decorationColor = Colors.red;
                } else if (_decorationColor == Colors.red) {
                  _decorationColor = Colors.blue;
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'AnimatedDecorationBox',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 实现一个AnimatedDecoratedBox，它可以在decoration属性发生变化时，从旧状态变成新状态的过程可以执行一个过渡动画。
class AnimatedDecorationBox extends StatefulWidget {
  AnimatedDecorationBox(
      {Key key,
      @required this.decoration,
      this.child,
      @required this.duration,
      this.curve,
      this.reverseDuration});

  final BoxDecoration decoration;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Duration reverseDuration;

  @override
  _AnimatedDecorationBoxState createState() => _AnimatedDecorationBoxState();
}

class _AnimatedDecorationBoxState extends State<AnimatedDecorationBox>
    with SingleTickerProviderStateMixin {
  @protected
  AnimationController get controller => _controller;
  AnimationController _controller;

  Animation<double> get animation => _animation;
  Animation<double> _animation;

  // 在两个装饰之间的插值
  DecorationTween _tween;

  @override
  void initState() {
    print('initState()');
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
      vsync: this,
    );
    _tween = DecorationTween(begin: widget.decoration);
    _updateCurve();
    super.initState();
  }

  void _updateCurve() {
    if (widget.curve != null) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    } else {
      _animation = _controller;
    }
  }

  // 第一次不会调用这个方法，当刷新时才会调用这个方法
  @override
  void didUpdateWidget(covariant AnimatedDecorationBox oldWidget) {
    print('didUpdateWidget()');
    if (widget.curve != oldWidget.curve) {
      _updateCurve();
    }
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    if (widget.decoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation)
        ..end = widget.decoration;
      _controller
        ..value = 0.0
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class AnimationTransitionFlutterRoute extends StatefulWidget {
  @override
  _AnimationTransitionFlutterRouteState createState() =>
      _AnimationTransitionFlutterRouteState();
}

class _AnimationTransitionFlutterRouteState
    extends State<AnimationTransitionFlutterRoute> {
  Color _decorationColor = Colors.blue;
  var duration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动画过渡组件-Flutter 封装的组件"),
      ),
      body: Center(
        // 使用继承自 Flutter 的 ImplicitlyAnimatedWidget 实现的 AnimatedDecoratedBox2
        child: AnimatedDecoratedBox2(
          decoration: BoxDecoration(color: _decorationColor),
          duration: duration,
          child: TextButton(
            onPressed: () {
              setState(() {
                if (_decorationColor == Colors.blue) {
                  _decorationColor = Colors.red;
                } else if (_decorationColor == Colors.red) {
                  _decorationColor = Colors.blue;
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'AnimatedDecorationBox',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 使用 Flutter 的封装实现
/// 通过继承 ImplicitlyAnimatedWidget 和 ImplicitlyAnimatedWidgetState 类可以快速的
/// 实现动画过渡组件的封装，这和我们纯手工实现相比，代码简化了很多。
class AnimatedDecoratedBox2 extends ImplicitlyAnimatedWidget {
  AnimatedDecoratedBox2({
    Key key,
    @required this.decoration,
    this.child,
    Curve curve = Curves.linear, // 动画曲线
    @required Duration duration, // 动画执行时长
  }) : super(key: key, curve: curve, duration: duration);

  final BoxDecoration decoration;
  final Widget child;

  @override
  _AnimatedDecoratedBox2State createState() => _AnimatedDecoratedBox2State();
}

/// AnimatedWidgetBaseState 继承自 ImplicitlyAnimatedWidgetState
class _AnimatedDecoratedBox2State
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox2> {
  DecorationTween _decoration; // 定义一个 Tween，指定了动画的开始状态和结束状态。

  @override
  Widget build(BuildContext context) {
    print('build()');
    return DecoratedBox(
      decoration: _decoration?.evaluate(animation),
      // 计算出的每一个值是一个 BoxDecoration。
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    print('forEachTween(): $visitor');
    // 更新 Tween 的初始值。
    // 当第一次展示的时候，_decoration 是 null，调用 visitor 方法会初始化 _decoration 的值；
    // 当刷新的时候，则更新 _decoration 的值。
    // typedef TweenVisitor<T> = Tween<T> Function(Tween<T> tween, T targetValue, TweenConstructor<T> constructor);
    // typedef TweenConstructor<T> = Tween<T> Function(T targetValue);
    _decoration = visitor(_decoration, widget.decoration, (value) {
      return DecorationTween(begin: value);
    });
  }
}

class AnimationTransitionFlutterWidgetRoute extends StatefulWidget {
  @override
  _AnimationTransitionFlutterWidgetRouteState createState() =>
      _AnimationTransitionFlutterWidgetRouteState();
}

class _AnimationTransitionFlutterWidgetRouteState
    extends State<AnimationTransitionFlutterWidgetRoute> {
  var _padding = 0.0;
  var _left = 0.0;
  var _align = Alignment.topLeft;
  var _height = 60.0;
  var _color = Colors.blue;
  static const TEXTSYLE1 = const TextStyle(
      color: Colors.blue, fontSize: 16, backgroundColor: Colors.red);
  static const TEXTSYLE2 = const TextStyle(
      color: Colors.red, fontSize: 24, backgroundColor: Colors.blue);
  TextStyle _textStyle = TEXTSYLE1;
  double opacityLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(seconds: 5);
    return Scaffold(
      appBar: AppBar(
        title: Text('动画过渡组件-Flutter 预置的组件'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_padding == 0.0) {
                      _padding = 20.0;
                    } else {
                      _padding = 0.0;
                    }
                  });
                },
                child: AnimatedPadding(
                  padding: EdgeInsets.all(_padding),
                  duration: duration,
                  child: Text('AnimatedPadding'),
                ),
              ),
              SizedBox(
                height: 50,
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_left == 0.0) {
                              _left = 100.0;
                            } else {
                              _left = 0.0;
                            }
                          });
                        },
                        child: Text('AnimatedPositioned'),
                      ),
                      duration: duration,
                      left: _left,
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                color: Colors.grey,
                child: AnimatedAlign(
                  duration: duration,
                  alignment: _align,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_align == Alignment.topLeft) {
                          _align = Alignment.center;
                        } else {
                          _align = Alignment.topLeft;
                        }
                      });
                    },
                    child: Text('AnimatedAlign'),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: duration,
                height: _height,
                color: _color,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (_color == Colors.red) {
                        _color = Colors.blue;
                        _height = 60;
                      } else {
                        _color = Colors.red;
                        _height = 100;
                      }
                    });
                  },
                  child: Text(
                    'AnimatedContainer',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              AnimatedDefaultTextStyle(
                child: GestureDetector(
                  child: Text('AnimatedDefaultTextStyle'),
                  onTap: () {
                    setState(() {
                      if (_textStyle == TEXTSYLE1) {
                        _textStyle = TEXTSYLE2;
                      } else {
                        _textStyle = TEXTSYLE1;
                      }
                    });
                  },
                ),
                style: _textStyle,
                duration: duration,
              ),
              AnimatedOpacity(
                duration: duration,
                opacity: opacityLevel,
                child: GestureDetector(
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: FlutterLogo(),
                  ),
                  onTap: () {
                    setState(() {
                      setState(() {
                        opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
                      });
                    });
                  },
                ),
              ),
            ].map((e) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: e,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
