import 'package:flutter/material.dart';
import 'dart:math' as math;

// 学习变换
// 1, Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子组件应用何种变化，
// 其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
// 2, RotatedBox和Transform.rotate功能相似，它们都可以对子组件进行旋转变换，但是有一点不同：
// RotatedBox的变换是在layout阶段，会影响在子组件的位置和大小。
class TransformRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('变换（Transform）')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return Demo1();
              }));
            },
            child: Text('Demo1'),
          ),
          RaisedButton(
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return TranslateRoute();
              }));
            },
            child: Text('平移'),
          ),
          RaisedButton(
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return RotateRoute();
              }));
            },
            child: Text('旋转'),
          ),
          RaisedButton(
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return ScaleRoute();
              }));
            },
            child: Text('缩放'),
          ),
          RaisedButton(
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return TransformFeatureRoute();
              }));
            },
            child: Text('变换特点'),
          ),
          RaisedButton(
            onPressed: () {
              return Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return RotatedBoxRoute();
              }));
            },
            child: Text('RotatedBox'),
          ),
        ],
      ),
    );
  }
}

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo1')),
      body: Container(
        margin: EdgeInsets.only(left: 100, top: 100),
        color: Colors.black,
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0.3),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.deepOrange,
            child: const Text('Apartment for rent!'),
          ),
        ),
      ),
    );
  }
}

class TranslateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('平移')),
      body: DecoratedBox(
        // 注意:背景没有发生移动
        decoration: BoxDecoration(color: Colors.red),
        // 默认原点是左上角,向右平移 20.0, 向下平移 5.0
        child: Transform.translate(
          offset: Offset(20.0, 5.0),
          child: Text('Hello world'),
        ),
      ),
    );
  }
}

class RotateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('旋转')),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            angle: math.pi / 2,
            child: Text('Hello world'),
          ),
        ),
      ),
    );
  }
}

class ScaleRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('缩放')),
      body: Container(
        margin: EdgeInsets.only(left: 100, top: 100),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.red),
          child: Transform.scale(
            scale: 2,
            child: Text('Hello world'),
          ),
        ),
      ),
    );
  }
}

class TransformFeatureRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('变换特点')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(color: Colors.red),
            child: Transform.scale(
              scale: 1.5,
              child: Text('Hello world'),
            ),
          ),
          Text(
            '你好',
            style: TextStyle(color: Colors.green),
          )
        ],
      ),
    );
  }
}

class RotatedBoxRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RotatedBox'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: RotatedBox(
                quarterTurns: 1,
                child: Text('Hello world'),
              ),
            ),
            Text(
              '你好',
              style: TextStyle(color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
