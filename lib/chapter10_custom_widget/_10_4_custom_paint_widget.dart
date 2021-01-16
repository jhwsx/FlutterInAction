import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10.4 自绘组件 （CustomPaint与Canvas）"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return GoBandPlateRoute();
              }));
            },
            child: Text('五子棋盘'),
          ),
        ],
      ),
    );
  }
}

// 五子棋盘
// 纵向有 16 个格子；横向有 16 个格子
class GoBandPlateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('五子棋盘'),
      ),
      body: Center(
        child: CustomPaint(
          // CustomPaint 相当于 Android 里面的 Canvas 画布了。
          size: Size(300.0, 300.0),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  static const LINE_COUNT = 15;

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / LINE_COUNT;
    double eHeight = size.height / LINE_COUNT;

    // 画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    // Offset 类的操作符
    // Rectangle constructor operator.
    // Rect operator &(Size other) => Rect.fromLTWH(dx, dy, other.width, other.height);
    canvas.drawRect(Offset.zero & size, paint);

    // 画棋盘网格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    // 画横线
    for (var i = 0; i <= LINE_COUNT; ++i) {
      double dy = i * eHeight;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    // 画纵线
    for (var i = 0; i <= LINE_COUNT; ++i) {
      double dx = i * eWidth;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
    final radius = min(eWidth / 2, eHeight / 2) - 2;

    // 画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(getOffsetByCoordinate(1, 1, eWidth, eHeight), radius, paint);
    // 画一个白子
    paint..color = Colors.white;
    canvas.drawCircle(getOffsetByCoordinate(14, 14, eWidth, eHeight), radius, paint);
  }

  Offset getOffsetByCoordinate(int x, int y, double eWidth, double eHeight) {
    if (x < 1 || x >= LINE_COUNT) throw Exception("x is invalid: $x");
    if (y < 1 || y >= LINE_COUNT) throw Exception("y is invalid: $y");
    return Offset(x * eWidth, y * eHeight);
  }

  // //在实际场景中正确利用此回调可以避免重绘开销, 这里我们简单地返回 true。
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
