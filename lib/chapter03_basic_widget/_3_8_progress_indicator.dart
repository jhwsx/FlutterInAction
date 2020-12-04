import 'package:flutter/material.dart';

// LinearProgressIndicator 和 CircularProgressIndicator 都是取父容器的尺寸作为绘制的边界的
class ProgressIndicatorRoute extends StatefulWidget {
  @override
  _ProgressIndicatorRouteState createState() => _ProgressIndicatorRouteState();
}

class _ProgressIndicatorRouteState extends State<ProgressIndicatorRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('进度指示器')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('线性进度条演示：'),
            // 不确定进度的进度条，value 为 null，则进度指示器执行一个循环动画
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              value: null,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            // 确定进度的进度条，value 为 [0, 1] 之间的值，则进度条是确定进度的。
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: 0.5,
            ),
            Text('圆形进度条演示：'),
            CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: null,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: 0.5,
            ),
            Text('自定义进度条演示：'),
            Text('——修改尺寸：'),
            SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            SizedBox(
              // 只指定一个尺寸，那么看起来就是椭圆的。
              height: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Text('——进度色动画：'),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                  .animate(_animationController),
              value: _animationController.value,
            ),
          ].map((e) {
            return Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                e,
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
