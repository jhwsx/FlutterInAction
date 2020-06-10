import 'package:flutter/material.dart';

// 学习弹性布局（Flex）
// 1, 弹性布局允许子组件按照一定的比例来分配父类容器空间
// 2, Flex 组件：
// 2.1, Row 和 Column 都是继承自 Flex 的。
// 2.2, Flex 继承自 MultiChildRenderObjectWidget，对应的 RenderObject (就是 createRenderObject
// 方法的返回值)为 RenderFlex， RenderFlex 中实现了其布局算法。
// 2.3, Flex 有一个必选的可选参数： @required this.direction, 表示弹性布局的方向，Row 和 Column 就是依据这个
// 值的传入来区分的，Row 传入的是 direction: Axis.horizontal, Column 传入的是 direction: Axis.vertical.
// 3, Expanded 组件：可以按“比例”扩伸 Row， Column 和 Flex 子组件所占用的空间
// 3.1，
class FlexRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('弹性布局（Flex）')),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          // 水平方向的红色色块：绿色色块为 1：2
          Text('水平方向的红色色块：绿色色块为 1:2'),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                  height: 50,
                  width: 50,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green,
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
          Text('垂直方向的红色色块：绿色色块：蓝色色块为 2:1:1'),
          SizedBox(
            // TODO 为什么这里加上了 SizedBox，就会让子组件占据屏幕的宽度呢？
            height: 300,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.red,
                    height: 50,
//                    width: 100,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.green,
                    height: 50,
//                    width: 100,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    height: 50,
//                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
