import 'package:flutter/material.dart';

// 学习尺寸限制类容器
// 1, 尺寸限制类容器用于限制容器的大小
class SizeConstrainedContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 指定一个背景为红色的盒子，没有指定它的宽度和高度
    var redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));
    return Scaffold(
      appBar: AppBar(title: Text('尺寸限制类容器')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('ConstrainedBox'),
          ),
          ConstrainedBox(
            // BoxConstraints 用于设置限制性的条件
            constraints: BoxConstraints(
              minWidth: double.infinity, // 宽度尽可能地大
              minHeight: 50.0, // 添加最小高度限制
            ),
            // 限定宽，高各为 100
//          constraints: BoxConstraints.tight(Size(100, 100)),

//          constraints: BoxConstraints.tight(Size(2,2)),

//            constraints: BoxConstraints.tightFor(width: 200, height: 200),

            // Creates box constraints that forbid sizes larger than the given size.
            // TODO 这个怎么没有效果？
//          constraints: BoxConstraints.loose(Size(100.0, 10.0)),

            child: Container(
              // Container 可以设置 redBox 的宽度和高度，这里指定的是高度为 5.0
              height: 5.0,
              child: redBox,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('SizedBox'),
          ),
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: redBox,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
                '多重 ConstrainedBox 限制: 对于 minWidth 和 minHeight 来说，是取父子中相应数值的较大者。'),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 100.0, minHeight: 20.0), // 父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 50.0, minHeight: 50.0), // 子
              child: redBox,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 50.0, minHeight: 60.0), // 父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 120.0, minHeight: 20.0),
              // 子
              child: redBox,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
                '多重 ConstrainedBox 限制: 对于 maxWidth 和 maxHeight 来说，无效, 最终宽高都是0。'),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100.0, maxHeight: 70.0), // 父
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 50.0, maxHeight: 50.0), // 子
              child: redBox,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ConstrainedBox(
            // 父
            constraints: BoxConstraints(maxWidth: 50.0, maxHeight: 50.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100.0, maxHeight: 70.0),
              // 子
              child: redBox,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            //不会对子组件产生任何限制，它允许其子组件按照其本身大小绘制。一般情况下，我们会很少直接使用此组件，但在"去除"多重限制的时候也许会有帮助
            child: Text('UnconstrainedBox 去除多重限制'),
          ),
          ConstrainedBox(
            // 父
            constraints: BoxConstraints(minWidth: 60, minHeight: 50),
            child: ConstrainedBox(
              // 子
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
              child: redBox,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ConstrainedBox(
            // 父
            constraints: BoxConstraints(minWidth: 60, minHeight: 50),
            // 去除父级限制
            child: UnconstrainedBox(
              child: ConstrainedBox(
                // 子
                constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),

                child: redBox,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
