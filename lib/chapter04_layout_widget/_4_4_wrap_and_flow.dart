import 'package:flutter/material.dart';

// 学习流式布局
// 1, Row 默认只有一行，超出屏幕不会折行。如果不进行任何处理，超出屏幕的溢出部分会报错。
// 2, 把超出屏幕显示范围会自动折行的布局称为流式布局。
// 3, Flutter 通过 Wrap 和 Flow 来支持流式布局。
// 4, Wrap 的属性：
//    final double spacing; 主轴方向子 widget 的间距, 默认是 0.0
//    final double runSpacing; 相交轴方向的间距
//    final WrapAlignment alignment; 沿主轴方向如何对齐
// 5, Flow 有些复杂，需要自己编写代码
class WrapAndFlowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('流式布局')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NoFlowRoute();
              }));
            },
            child: Text('不使用流式布局出现的问题'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WrapFixRoute();
              }));
            },
            child: Text('使用流式布局 Wrap 解决问题'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WrapDemoRoute();
              }));
            },
            child: Text('Wrap Demo'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FlowDemoRoute();
              }));
            },
            child: Text('Flow Demo'),
          ),
        ],
      ),
    );
  }
}

class NoFlowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('不使用流式布局出现的问题')),
      body: Row(
        children: [
          Text('x' * 1000),
        ],
      ),
    );
  }
}

class WrapFixRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('使用流式布局 Wrap 解决问题')),
      body: Wrap(
        children: [
          Text('x' * 1000),
        ],
      ),
    );
  }
}

class WrapDemoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wrap Demo')),
      body: Wrap(
        // 主轴方向子 widget 的间距
        spacing: 8.0,
        // 相交轴方向的间距
        runSpacing: 4.0,
        // 沿主轴方向居中
        alignment: WrapAlignment.center,
//        runAlignment: WrapAlignment.center,
        children: <Widget>[
          Chip(
            label: Text('Android'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A'),
            ),
          ),
          Chip(
            label: Text('Java'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('J'),
            ),
          ),
          Chip(
            label: Text('Flutter'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('F'),
            ),
          ),
          Chip(
            label: Text('Kotlin'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('K'),
            ),
          ),
          Chip(
            label: Text('Dart'),
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('D'),
            ),
          ),
        ],
      ),
    );
  }
}

class FlowDemoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlowDemo"),
      ),
      body: Flow(
        delegate: FlowDemoDelegate(margin: EdgeInsets.all(10.0)),
        children: <Widget>[
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.red,
          ),
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.orange,
          ),
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.yellow,
          ),
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.green,
          ),
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.blue,
          ),
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.cyan,
          ),
          Container(
            width: 100.0,
            height: 80.0,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class FlowDemoDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  FlowDemoDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
