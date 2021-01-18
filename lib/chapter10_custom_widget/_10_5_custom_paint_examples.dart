import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter10_custom_widget/_10_3_composite_examples.dart';

class CustomPaintExamplesRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10.5 自绘实例"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return GradientCircularProgressRoute();
              }));
            },
            child: Text('圆形背景渐变进度条'),
          ),
        ],
      ),
    );
  }
}

class GradientCircularProgressRoute extends StatefulWidget {
  @override
  _GradientCircularProgressRouteState createState() =>
      _GradientCircularProgressRouteState();
}

class _GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    bool isForward = true;
    // 设置动画状态监听器
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        // 动画执行结束或者动画恢复到初始状态
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('圆形背景渐变进度条'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: <Widget>[
                          Wrap(
                            // 主轴方向子 widget 的间距, 默认是 0.0
                            spacing: 10.0,
                            // 相交轴方向的间距
                            runSpacing: 16.0,
                            children: <Widget>[
                              GradientCircularProgressIndicator(
                                radius: 50.0,
                                colors: [Colors.blue, Colors.blue],
                                strokeWidth: 3.0,
                                value: _animationController.value,
                              ),
                              GradientCircularProgressIndicator(
                                radius: 50.0,
                                colors: [Colors.red, Colors.orange],
                                strokeWidth: 3.0,
                                value: _animationController.value,
                              ),
                              GradientCircularProgressIndicator(
                                radius: 50.0,
                                colors: [Colors.red, Colors.orange, Colors.red],
                                strokeWidth: 5.0,
                                value: _animationController.value,
                              ),
                              GradientCircularProgressIndicator(
                                radius: 50.0,
                                colors: [Colors.teal, Colors.cyan],
                                strokeWidth: 5.0,
                                strokeCapRound: true,
                                value: CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.decelerate)
                                    .value,
                              ),
                              TurnBox(
                                turns: 1 / 8,
                                child: GradientCircularProgressIndicator(
                                  colors: [
                                    Colors.red,
                                    Colors.orange,
                                    Colors.red
                                  ],
                                  radius: 50.0,
                                  strokeWidth: 5.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.red[50],
                                  totalAngle: 1.5 * pi,
                                  value: CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.ease,
                                  ).value,
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 1,
                                child: GradientCircularProgressIndicator(
                                  colors: [Colors.blue[700], Colors.blue[200]],
                                  radius: 50.0,
                                  strokeWidth: 3.0,
                                  strokeCapRound: true,
                                  backgroundColor: Colors.transparent,
                                  value: _animationController.value,
                                ),
                              ),
                              GradientCircularProgressIndicator(
                                radius: 50.0,
                                colors: [
                                  Colors.red,
                                  Colors.amber,
                                  Colors.cyan,
                                  Colors.green[200],
                                  Colors.blue,
                                  Colors.red
                                ],
                                strokeWidth: 5.0,
                                strokeCapRound: true,
                                value: _animationController.value,
                              ),
                            ],
                          ),
                          GradientCircularProgressIndicator(
                            radius: 100.0,
                            colors: [Colors.blue[700], Colors.blue[200]],
                            strokeWidth: 20.0,
                            value: _animationController.value,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: GradientCircularProgressIndicator(
                              colors: [Colors.blue[700], Colors.blue[300]],
                              radius: 100.0,
                              strokeWidth: 20.0,
                              value: _animationController.value,
                              strokeCapRound: true,
                            ),
                          ),
                          // 裁剪半圆
                          ClipRect(
                            child: Align(
                              alignment: Alignment.topCenter,
                              heightFactor: 0.5,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  child: TurnBox(
                                    turns: 0.75,
                                    child: GradientCircularProgressIndicator(
                                      colors: [Colors.teal, Colors.cyan[500]],
                                      radius: 100.0,
                                      strokeWidth: 8.0,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 104.0,
                            width: 200.0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  height: 200.0,
                                  top: .0,
                                  child: TurnBox(
                                    turns: 0.75,
                                    child: GradientCircularProgressIndicator(
                                      colors: [Colors.teal, Colors.cyan[500]],
                                      radius: 100.0,
                                      strokeWidth: 8.0,
                                      value: _animationController.value,
                                      totalAngle: pi,
                                      strokeCapRound: true,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "${(_animationController.value * 100).toInt()}%",
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.blueGrey,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator(
      {this.strokeWidth = 2.0,
      @required this.radius,
      @required this.colors,
      this.stops,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      this.value});

  /// 粗细
  final double strokeWidth;

  /// 圆的半径
  final double radius;

  /// 两端是否是圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2 * PI 是整圆，小于 2 * PI 则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应 colors 属性
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    double _offset = 0.0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏移起始位置
    if (strokeCapRound) {
      _offset = asin(strokeWidth / (radius * 2 - strokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      // 没有设置渐变色数组，这里指定一个默认的。
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        // Creates a square [Size] whose [width] and [height] are twice the given
        // dimension.
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.strokeWidth = 10.0,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.radius,
      this.total = 2 * pi,
      @required this.colors,
      this.stops,
      this.value});

  /// 粗细
  final double strokeWidth;

  /// 两端是否是圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 渐变色数组
  final List<Color> colors;
  final double total;

  /// 圆的半径
  final double radius;

  /// 渐变色的终止点，对应 colors 属性
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = strokeWidth / 2.0;
    double _value = value ?? 0.0;
    // _value.clamp(0.0, 1.0) 得到的值卡在 0.0 到 1.0 之间，
    // 如果 _value 的值比 0.0 还小，则得到的值是 0.0；
    // 如果 _value 的值比 1.0 还大，则得到的值是 1.0.
    _value = _value.clamp(0.0, 1.0) * total;
    // 起始角度
    double _start = 0.0;

    if (strokeCapRound) {
      _start = asin(strokeWidth / (size.width - strokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    // 先绘制背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }
    // 再绘制前景，应用渐变
    if (_value > 0) {
      // 设置着色器，跟 Android 挺像的啊。
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
