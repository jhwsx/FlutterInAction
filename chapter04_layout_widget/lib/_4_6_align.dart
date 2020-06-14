import 'package:flutter/material.dart';

// 学习 Align 组件
// 1, 作用：可以在 Align 组件的内部对齐它的子组件，并且可以基于子组件的大小来调整 Align 组件的大小
// 2, 坐标转换公式
// (Alignment.x*childWidth/2+childWidth/2, Alignment.y*childHeight/2+childHeight/2)
// x 的取值范围是 [-1, 1], y 的取值范围是 [-1,1].
// 3, final double widthFactor 如果不是 null，用于确定 Align 的宽度： 子组件的宽度乘以该因子。
// 可以比 1.0 大也可以比 1.0 小，但必须是正值。
// 和 final double heightFactor 如果不是 null，用于确定 Align 的高度： 子组件的宽度乘以该因子。
//// 可以比 1.0 大也可以比 1.0 小，但必须是正值。
// 4, FractionalOffset 继承自 Alignment， 和 Alignment 的唯一区别是坐标原点不同，
// FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致。 而 Alignment Widget 会以矩形的中心点作为坐标原点
// 实际偏移 = (FractionalOffse.x * childWidth, FractionalOffse.y * childHeight)
// 5, Align 和 Stack 的区别：
// Align 只能有一个子组件，不存在堆叠，而 Stack 可以有多个子组件，而子组件可以堆叠。
// 定位参考系统不同，Stack 定位的参考系可以是父容器的 4 个顶点，而 Align 需要先通过 alignment 参数
// 确定坐标原点。
class AlignRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('对齐与相对定位（Align）')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Demo1Route();
              }));
            },
            color: Colors.blue,
            child: Text('Demo1'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Demo2Route();
              }));
            },
            color: Colors.blue,
            child: Text('Demo2'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Demo3Route();
              }));
            },
            color: Colors.blue,
            child: Text('Demo3'),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Demo4Route();
              }));
            },
            color: Colors.blue,
            child: Text('Demo4'),
          ),
        ],
      ),
    );
  }
}

class Demo1Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo1')),
      body: Container(
        height: 120.0,
        width: 120.0,
        color: Colors.blue[50],
        child: Align(
          // 把子组件定位在右上角
//          alignment: Alignment.topRight,
          alignment: Alignment(1, -1),
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}

class Demo2Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo2')),
      body: Container(
        color: Colors.blue[50],
        child: Align(
          widthFactor: 2.0,
          heightFactor: 2.0,
          // 把子组件定位在右上角
//          alignment: Alignment.topRight,
          alignment: Alignment(1, -1),
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}

class Demo3Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo3')),
      body: Container(
        color: Colors.blue[50],
        child: Align(
          widthFactor: 2.0,
//          heightFactor: 2.0,
          // 把子组件定位在右上角
//          alignment: Alignment.topRight,
          alignment: Alignment(1, -1),
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}

class Demo4Route extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Demo4')),
      body: Container(
        color: Colors.blue[50],
        child: Align(
          widthFactor: 2.0,
          heightFactor: 2.0,
          // 把子组件定位在右上角
          alignment: FractionalOffset(2, 2),
          child: FlutterLogo(
            size: 60,
          ),
        ),
      ),
    );
  }
}
