import 'package:flutter/material.dart';
// 通常SingleChildScrollView只应在期望的内容不会超过屏幕太多时使用，这是因为SingleChildScrollView
// 不支持基于Sliver的延迟实例化模型，所以如果预计视口可能包含超出屏幕尺寸太多的内容时，那么使用
// SingleChildScrollView将会非常昂贵（性能差），此时应该使用一些支持Sliver延迟加载的可滚动组件，如ListView。
class SingleChildScrollViewRoute extends StatefulWidget {
  @override
  _SingleChildScrollViewState createState() {
    return _SingleChildScrollViewState();
  }
}

class _SingleChildScrollViewState extends State<SingleChildScrollViewRoute> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      print("滚动位置：${_controller.offset}");
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text('SingleChildScrollView'),
      ),
      body: Scrollbar( // 显示进度条
        thickness: 5.0, // 进度条的宽度
        radius: Radius.circular(2.5), // 进度条的圆角半径
        isAlwaysShown: true, // 是否总是显示进度条
        controller: _controller,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // 滚动方向，默认是垂直方向
          reverse: false,
          controller: _controller,
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: str
                  .split("")
                  .map((e) =>
                  Text(
                    e,
                    textScaleFactor: 2.0,
                  ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

}
