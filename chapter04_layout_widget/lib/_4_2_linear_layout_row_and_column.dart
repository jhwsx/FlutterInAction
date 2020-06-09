import 'package:flutter/material.dart';

class RowAndColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('线性布局（Row和Column）'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RowRoute();
                }));
              },
              child: Text('Row'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ColumnRoute();
                }));
              },
              child: Text('Column'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ColumnCenterRoute1();
                }));
              },
              child: Text('Column 居中1'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ColumnCenterRoute2();
                }));
              },
              child: Text('Column 居中2'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ColumnCenterRoute3();
                }));
              },
              child: Text('Column 居中3'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SpecialCaseRoute();
                }));
              },
              child: Text('列嵌套列，或行嵌套行'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SpecialCaseFixRoute();
                }));
              },
              child: Text('列嵌套列，或行嵌套行解决'),
            ),
          ],
        ),
      ),
    );
  }
}

class RowRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Row'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            // mainAxisSize 默认是 MainAxisSize.max，占据主轴上的所有空间
            // 当 mainAxisSize 为 MainAxisSize.max 时，mainAxisAlignment 才有效果：
            // 它的含义是在主轴上如何定位 children。
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('hello world'),
              Text('I am Jack'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            // 因为 mainAxisSize 设置为了 MainAxisSize.min，所以 mainAxisAlignment 的设置没有效果
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('hello world'),
              Text('I am Jack'),
            ],
          ),
          Row(
            // 表示水平方向子组件的布局顺序(是从左往右还是从右往左)，默认为系统当前Locale环境的文本方向
            // (如中文、英语都是从左往右，而阿拉伯语是从右往左)。
            textDirection: TextDirection.rtl, // 这个属性应该很少用到吧。
            children: <Widget>[
              Text('hello world'),
              Text('I am Jack'),
            ],
          ),
          Row(
            // 靠行尾布局
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('hello world'),
              Text('I am Jack'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text('hello world'),
              Text('I am Jack'),
            ],
          ),
          Row(
            // 在相交轴上靠哪边对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: [
              Text(
                'hello world',
                style: TextStyle(fontSize: 30.0),
              ),
              Text('I am Jack'),
            ],
          ),
        ],
      ),
    );
  }
}

class ColumnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column'),
      ),
      body: Column(
        // Column 的高度是占据了屏幕的高度的空间
        // crossAxisAlignment: CrossAxisAlignment.center 指定了在相交轴上如何定位 children
        // 设置为 center，表示在相交轴上居中定位 children。
        // 相交轴的宽度是由最宽的 child 决定的，这里是由 world 这个文本决定的。
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('hi'),
          Text('world'),
        ],
      ),
    );
  }
}

// 使用 ConstrainedBox：这种方式是把 Column 的宽度真的变成了屏幕的宽度
class ColumnCenterRoute1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column 居中1'),
      ),
      body: ConstrainedBox(
        // 约束条件
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Column(
          // Column 的高度是占据了屏幕的高度的空间
          // crossAxisAlignment: CrossAxisAlignment.center 指定了在相交轴上如何定位 children
          // 设置为 center，表示在相交轴上居中定位 children。
          // 相交轴的宽度是由最宽的 child 决定的，这里是由 world 这个文本决定的。
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hi'),
            Text('world'),
          ],
        ),
      ),
    );
  }
}

// 使用 Row + Expanded：这种方式是把 Column 的宽度真的变成了屏幕的宽度
class ColumnCenterRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column 居中2'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              // Column 的高度是占据了屏幕的高度的空间
              // crossAxisAlignment: CrossAxisAlignment.center 指定了在相交轴上如何定位 children
              // 设置为 center，表示在相交轴上居中定位 children。
              // 相交轴的宽度是由最宽的 child 决定的，这里是由 world 这个文本决定的。
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('hi'),
                Text('world'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 使用 Center：：这种方式是没有改变 Column 的宽度，还是 world 的宽度。
class ColumnCenterRoute3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column 居中3'),
      ),
      body: Center(
        child: Column(
          // Column 的高度是占据了屏幕的高度的空间
          // crossAxisAlignment: CrossAxisAlignment.center 指定了在相交轴上如何定位 children
          // 设置为 center，表示在相交轴上居中定位 children。
          // 相交轴的宽度是由最宽的 child 决定的，这里是由 world 这个文本决定的。
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('hi'),
            Text('world'),
          ],
        ),
      ),
    );
  }
}

class SpecialCaseRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('列嵌套列，或行嵌套行')),
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                color: Colors.red,
                child: Column(
                  children: [
                    Text('hello world!'),
                    Text("I'm Jack."),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpecialCaseFixRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('列嵌套列，或行嵌套行解决')),
      body: Container(
        color: Colors.green,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text('hello world!'),
                      Text("I'm Jack."),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
