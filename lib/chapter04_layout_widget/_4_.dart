import 'package:flutter/material.dart';

import '_4_2_linear_layout_row_and_column.dart';
import '_4_3_flex.dart';
import '_4_4_wrap_and_flow.dart';
import '_4_5_stack_and_positioned.dart';
import '_4_6_align.dart';

class Chapter04LayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第四章: 布局类组件')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RowAndColumnRoute();
              }));
            },
            child: Text('4.2 线性布局（Row和Column）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FlexRoute();
              }));
            },
            child: Text('4.3 弹性布局（Flex）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WrapAndFlowRoute();
              }));
            },
            child: Text('4.4 流式布局'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return StackAndPostionedRoute();
              }));
            },
            child: Text('4.5 层叠布局 Stack、Positioned'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AlignRoute();
              }));
            },
            child: Text('4.6 对齐与相对定位（Align）'),
          ),
        ],
      ),
    );
  }
}
