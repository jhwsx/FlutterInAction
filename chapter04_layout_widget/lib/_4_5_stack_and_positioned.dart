import 'package:flutter/material.dart';

// 学习 Stack
// 1, Stack 的作用是让子组件层叠在一起，子组件越往后，层级越靠上。
// 2, 属性：
// 2.1 final AlignmentGeometry alignment; 决定如何去对齐没有定位或者部分定位的子组件。
// 2.2 final TextDirection textDirection; 用于确定 alignment 对齐的参考系。
// 2.3 final StackFit fit; 如何让没有定位的子组件适应 Stack 的大小。Stack.loose 表示使用子组件的大小，
// StackFit.expand 表示扩展到 Stack 的大小。
// 2.4 final Overflow overflow; 决定如何显示超出 Stack 显示空间的子组件，取值为 Overflow.clip
// 时，超出部分会被裁剪，取值为 Overflow.visible 时，则不会被裁剪。
// 3, Positioned 控制 Stack 的子组件定位在什么地方
// 3.1 Positioned 组件必须是 Stack 的子组件。
// 3.2 left，width 两个给定了，就确定了 right。不能再指定 right 了。
// 3.3 如果在一个特定轴上的 3 个属性都是 null，那么就由 Stack 的 alignment 属性来定位子组件。
// 3.4 如果 6 个属性都是 null，那么子组件是一个没有定位的子组件。Stack 仅仅使用没有定位的子组件来
// 确定自己的大小。
class StackAndPostionedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('层叠布局 Stack、Positioned')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StackDemo1Route();
              }));
            },
            child: Text('Stack Demo1'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StackDemo2Route();
              }));
            },
            child: Text('Stack Demo2'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StackDemo3Route();
              }));
            },
            child: Text('Stack Demo3'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StackDemo4Route();
              }));
            },
            child: Text('Stack Demo4'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StackDemo5Route();
              }));
            },
            child: Text('Stack Demo5'),
          ),
        ],
      ),
    );
  }
}

class StackDemo1Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Demo1')),
      body: ConstrainedBox(
        // ConstrainedBox 可以给子组件添加额外的约束
        // 通过 ConstrainedBox 来确保 Stack 占满屏幕
        constraints: BoxConstraints.expand(),
        child: Stack(
          // How to align the non-positioned and partially-positioned children in the stack.
          alignment: AlignmentDirectional.center,
//          fit: StackFit.expand,
          children: <Widget>[
            // Container 位于中心的位置，因为它没有指定定位，就是说没有 Positioned。
            Container(
              //  A convenience widget that combines common painting, positioning, and sizing widgets.
              child: Text('Hello world', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              padding: EdgeInsets.all(8.0),
            ),
            Positioned(
              // 这个 Text 指定了水平方向的定位（left: 18.0）,竖直方向没有指定定位，所以说
              // 它是部分定位的。垂直方向没有指定定位，那么在垂直方向上会按照 Stack 的 alignment 属性
              // 指定的对齐方式来对齐，也就是说在垂直方向上是会居中的。
              child: Text('I am Jack'),
              left: 18.0,
            ),
            Positioned(
              // 这个 Text 指定了垂直方向的定位（top: 18.0）,水平方向没有指定定位，所以说
              // 它是部分定位的。水平方向没有指定定位，那么在水平方向上会按照 Stack 的 alignment 属性
              // 指定的对齐方式来对齐，也就是说在水平方向上是会居中的。
              child: Text('Your friend'),
              top: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}

class StackDemo2Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Demo2')),
      body: ConstrainedBox(
        // ConstrainedBox 可以给子组件添加额外的约束
        // 通过 ConstrainedBox 来确保 Stack 占满屏幕
        constraints: BoxConstraints.expand(),
        child: Stack(
          // How to align the non-positioned and partially-positioned children in the stack.
          alignment: AlignmentDirectional.center,
          // 没有定位的子组件会扩展到 Stack 的大小。这里就是 Hello world 文本。
          fit: StackFit.expand,
          children: <Widget>[
            // Container 位于中心的位置，因为它没有指定定位，就是说没有 Positioned。
            Container(
              //  A convenience widget that combines common painting, positioning, and sizing widgets.
              child: Text('Hello world', style: TextStyle(color: Colors.white)),
              color: Colors.red,
              padding: EdgeInsets.all(8.0),
            ),
            Positioned(
              // 这个 Text 指定了水平方向的定位（left: 18.0）,竖直方向没有指定定位，所以说
              // 它是部分定位的。垂直方向没有指定定位，那么在垂直方向上会按照 Stack 的 alignment 属性
              // 指定的对齐方式来对齐，也就是说在垂直方向上是会居中的。
              child: Text('I am Jack'),
              left: 18.0,
            ),
            Positioned(
              // 这个 Text 指定了垂直方向的定位（top: 18.0）,水平方向没有指定定位，所以说
              // 它是部分定位的。水平方向没有指定定位，那么在水平方向上会按照 Stack 的 alignment 属性
              // 指定的对齐方式来对齐，也就是说在水平方向上是会居中的。
              child: Text('Your friend'),
              top: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}

class StackDemo3Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Demo3')),
      body: ConstrainedBox(
        // ConstrainedBox 可以给子组件添加额外的约束
        // 通过 ConstrainedBox 来确保 Stack 占满屏幕
        constraints: BoxConstraints.expand(),
        child: Stack(
          // 默认是在左上角对齐的
          // 先出现的子组件是在底部，后出现的子组件会叠加在上面。
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 90,
              height: 90,
              color: Colors.green,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class StackDemo4Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Demo4')),
      body: SizedBox(
        width: 250,
        height: 250,
        child: Stack(
          children: <Widget>[
            // 最底下的一层是白色的
            Container(
              width: 250,
              height: 250,
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              // 为什么 Container 会占据 250, 250 的位置呢？
              /// Align the [child] within the container.
              ///
              /// If non-null, the container will expand to fill its parent and position its
              /// child within itself according to the given value. If the incoming
              /// constraints are unbounded, then the child will be shrink-wrapped instead.
              // 如果不是 null，那么 container 会扩展到填充它的父组件并且把它的子组件根据 alignment 的值
              // 来定位。
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.black45,
                  ],
                ),
              ),
              child: Text(
                'Foreground Text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StackDemo5Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stack Demo5')),
      body: SizedBox(
        width: 250,
        height: 250,
        child: Stack(
          overflow: Overflow.visible,
//          overflow: Overflow.clip,
          children: [
            Container(
              width: 250,
              height: 250,
              color: Colors.grey,
            ),
            Positioned(
              left: 10,
              child: Text('123456789abcde' * 10),
            ),
          ],
        ),
      ),
    );
  }
}
