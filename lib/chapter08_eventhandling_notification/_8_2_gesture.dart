import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("8.2 手势识别"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorTapPressRoute();
              }));
            },
            child: Text("GestureDetector 之点击、双击、长按"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorDragRoute();
              }));
            },
            child: Text("GestureDetector 之拖动、滑动"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorVerticalDragRoute();
              }));
            },
            child: Text("GestureDetector 之单一方向拖动"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorScaleRoute();
              }));
            },
            child: Text("GestureDetector 之缩放"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureRecognizerTestRoute();
              }));
            },
            child: Text("GestureRecognizer 之点击部分文本变色"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorArenaRoute();
              }));
            },
            child: Text("GestureDetector 之竞争"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorConflictRoute();
              }));
            },
            child: Text("GestureDetector 之手势冲突"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GestureDetectorFixConflictRoute();
              }));
            },
            child: Text("GestureDetector 之解决手势冲突"),
          ),
        ],
      ),
    );
  }
}

class GestureDetectorTapPressRoute extends StatefulWidget {
  @override
  _GestureDetectorTapPressRouteState createState() =>
      _GestureDetectorTapPressRouteState();
}

class _GestureDetectorTapPressRouteState
    extends State<GestureDetectorTapPressRoute> {
  var _state = '';

  _changeState(String value) {
    setState(() {
      print(value);
      _state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之点击、双击、长按"),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              _state,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // 注意：不要把回调写错了，不然点击没有反应，也不报错。
          onTap: () => _changeState("onTap, 点击"),
          onDoubleTap: () => _changeState("onDoubleTap, 双击"),
          onLongPress: () => _changeState("onLongPress, 长按"),
          // onTapDown: (TapDownDetails details) {
          //   _changeState('onTapDown'
          //       ' ${details.globalPosition.dx}'
          //       ' ${details.globalPosition.dy}');
          // },
          // onTapUp: (TapUpDetails details) {
          //   _changeState('onTapUp'
          //       ' ${details.globalPosition.dx}'
          //       ' ${details.globalPosition.dy}');
          // },
          // onTapCancel: _changeState('onTapCancel'),
        ),
      ),
    );
  }
}

class GestureDetectorDragRoute extends StatefulWidget {
  @override
  _GestureDetectorDragRouteState createState() =>
      _GestureDetectorDragRouteState();
}

class _GestureDetectorDragRouteState extends State<GestureDetectorDragRoute> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之拖动、滑动"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
                backgroundColor: Colors.blue,
              ),
              // typedef GestureDragDownCallback = void Function(DragDownDetails details);
              onPanDown: (DragDownDetails details) {
                // 手指按下时回调
                print('用户手指按下的位置：${details.globalPosition}');
              },
              // typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
              onPanUpdate: (DragUpdateDetails details) {
                // 手指滑动时回调
                setState(() {
                  _left += details.delta.dx;
                  _top += details.delta.dy;
                });
              },
              // typedef GestureDragEndCallback = void Function(DragEndDetails details);
              onPanEnd: (DragEndDetails details) {
                // 手指滑动结束时回调
                print('滑动结束时的速度：${details.velocity}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GestureDetectorVerticalDragRoute extends StatefulWidget {
  @override
  _GestureDetectorVerticalDragRouteState createState() =>
      _GestureDetectorVerticalDragRouteState();
}

class _GestureDetectorVerticalDragRouteState
    extends State<GestureDetectorVerticalDragRoute> {
  double _top = 0.0;

  // double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之单一方向拖动"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            // left: _left,
            top: _top,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text('A'),
                backgroundColor: Colors.blue,
              ),
              // typedef GestureDragDownCallback = void Function(DragDownDetails details);
              onPanDown: (DragDownDetails details) {
                // 手指按下时回调
                print('用户手指按下的位置：${details.globalPosition}');
              },
              // typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
              onPanUpdate: (DragUpdateDetails details) {
                // 手指滑动时回调
                setState(() {
                  // _left += details.delta.dx;
                  _top += details.delta.dy;
                });
              },
              // typedef GestureDragEndCallback = void Function(DragEndDetails details);
              onPanEnd: (DragEndDetails details) {
                // 手指滑动结束时回调
                print('滑动结束时的速度：${details.velocity}');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GestureDetectorScaleRoute extends StatefulWidget {
  @override
  _GestureDetectorScaleRouteState createState() =>
      _GestureDetectorScaleRouteState();
}

class _GestureDetectorScaleRouteState extends State<GestureDetectorScaleRoute> {
  double _width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之缩放"),
      ),
      body: Center(
        child: GestureDetector(
          child: Image.asset(
            "./images/wzc_avatar.webp",
            width: _width,
          ),
          // typedef GestureScaleUpdateCallback = void Function(ScaleUpdateDetails details);
          onScaleUpdate: (ScaleUpdateDetails details) {
            setState(() {
              // 缩放倍数在0.8到10倍之间
              _width = 200.0 * details.scale.clamp(0.0, 10.0);
            });
          },
        ),
      ),
    );
  }
}

class GestureRecognizerTestRoute extends StatefulWidget {
  @override
  _GestureRecognizerTestRouteState createState() =>
      _GestureRecognizerTestRouteState();
}

class _GestureRecognizerTestRouteState
    extends State<GestureRecognizerTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false;

  @override
  void dispose() {
    // 使用GestureRecognizer后一定要调用其dispose()方法来释放资源（主要是取消内部的计时器）
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureRecognizer 之点击部分文本变色"),
      ),
      body: Center(
        child: Text.rich(TextSpan(
          children: <InlineSpan>[
            TextSpan(text: "元旦快乐"),
            TextSpan(
              text: "点我变色",
              style: TextStyle(
                fontSize: 30.0,
                color: _toggle ? Colors.blue : Colors.red,
              ),
              recognizer: _tapGestureRecognizer
                // typedef GestureTapCallback = void Function();
                ..onTap = () {
                  setState(() {
                    _toggle = !_toggle;
                  });
                },
            ),
            TextSpan(text: "元旦快乐"),
          ],
        )),
      ),
    );
  }
}

class GestureDetectorArenaRoute extends StatefulWidget {
  @override
  _GestureDetectorArenaRouteState createState() =>
      _GestureDetectorArenaRouteState();
}

class _GestureDetectorArenaRouteState extends State<GestureDetectorArenaRoute> {
  var _left = 0.0;
  var _top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之竞争"),
      ),
      body: ConstrainedBox(
        // 这是为了让 Stack 充满屏幕。
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Text("拖动 A，不会沿着斜线走。"),
            Positioned(
              left: _left,
              top: _top,
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text('A'),
                ),
                // typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _top += details.delta.dy;
                  });
                },
                // typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GestureDetectorConflictRoute extends StatefulWidget {
  @override
  _GestureDetectorConflictRouteState createState() {
    return _GestureDetectorConflictRouteState();
  }
}

class _GestureDetectorConflictRouteState
    extends State<GestureDetectorConflictRoute> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之手势冲突"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              // typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _left += details.delta.dx;
                });
              },
              // typedef GestureDragEndCallback = void Function(DragEndDetails details);
              onHorizontalDragEnd: (DragEndDetails details) {
                print('onHorizontalDragEnd');
              },
              // typedef GestureTapDownCallback = void Function(TapDownDetails details);
              onTapDown: (TapDownDetails details) {
                print('tap down');
              },
              // typedef GestureTapUpCallback = void Function(TapUpDetails details);
              onTapUp: (TapUpDetails details) {
                print('tap up');
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 在遇到复杂的冲突场景时，都可以通过Listener直接识别原始指针事件来解决冲突。
class GestureDetectorFixConflictRoute extends StatefulWidget {
  @override
  _GestureDetectorFixConflictRouteState createState() {
    return _GestureDetectorFixConflictRouteState();
  }
}

class _GestureDetectorFixConflictRouteState
    extends State<GestureDetectorFixConflictRoute> {
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GestureDetector 之解决手势冲突"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            child: Listener(
              // typedef PointerDownEventListener = void Function(PointerDownEvent event);
              onPointerDown: (PointerDownEvent event) {
                print('pointer down');
              },
              onPointerUp: (PointerUpEvent event) {
                print('pointer up');
              },
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text("A"),
                ),
                // typedef GestureDragUpdateCallback = void Function(DragUpdateDetails details);
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    _left += details.delta.dx;
                  });
                },
                // typedef GestureDragEndCallback = void Function(DragEndDetails details);
                onHorizontalDragEnd: (DragEndDetails details) {
                  print('onHorizontalDragEnd');
                },
                // // typedef GestureTapDownCallback = void Function(TapDownDetails details);
                // onTapDown: (TapDownDetails details) {
                //   print('tap down');
                // },
                // // typedef GestureTapUpCallback = void Function(TapUpDetails details);
                // onTapUp: (TapUpDetails details) {
                //   print('tap up');
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
