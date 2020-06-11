import 'package:chapter04layoutwidget/_4_4_wrap_and_flow.dart';
import 'package:flutter/material.dart';
import '_4_2_linear_layout_row_and_column.dart';
import '_4_3_flex.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第四章 布局类组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第四章 布局类组件')),
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
        ],
      ),
    );
  }
}
