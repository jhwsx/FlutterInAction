import 'package:flutter/material.dart';
// 交织动画的注意点

// 要使用交织动画，需要使用多个动画对象（Animation）
// 一个 AnimationController 控制所有的动画对象
// 给每一个动画对象指定时间间隔（Interval），介于0.0和1.0之间
class StaggeredAnimationsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("9.5 交织动画")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return StaggeredAnimationsDemo1Route();
              }));
            },
            child: Text('交织动画-柱状图增长效果'),
          ),
        ],
      ),
    );
  }
}

class StaggeredAnimationsDemo1Route extends StatefulWidget {
  @override
  _StaggeredAnimationsDemo1RouteState createState() =>
      _StaggeredAnimationsDemo1RouteState();
}

// 有多个 AnimationController, 则应该使用 TickerProviderStateMixin
// TODO 源代码使用的是 TickerProviderStateMixin，我觉得应该是 SingleTickerProviderStateMixin
class _StaggeredAnimationsDemo1RouteState
    extends State<StaggeredAnimationsDemo1Route> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  // 为什么用 async，await？
  // await 关键字来得到异步表达式的 completed 结果
  // 如果在函数里使用了 await 关键字，那么就必须在函数体前加上 async 关键字。
  Future<Null> _playAnimation() async {
    try {
      // 先正向执行动画
       await _controller.forward().orCancel;
      // 再反向执行动画
       await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交织动画-柱状图增长效果'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            child: StaggerAnimation(
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}

// 开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
// 高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    // 高度动画
    height = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, // 间隔，前 60% 的动画时间
          curve: Curves.ease,
        ),
      ),
    );
    // 颜色动画
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0, 0.6, // 间隔，前 60% 的动画时间
          curve: Curves.ease,
        ),
      ),
    );
    // 平移动画
    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: 0.0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 1.0, // 间隔，后 40% 的动画时间
            curve: Curves.ease),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }
}
