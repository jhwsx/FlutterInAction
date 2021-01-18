import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter10_custom_widget/_10_4_custom_paint_widget.dart';
import 'package:flutter_in_action/chapter10_custom_widget/_10_5_custom_paint_examples.dart';

import '_10_2_composite_existing_widget.dart';
import '_10_3_composite_examples.dart';

class CustomWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第十章：自定义组件"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return CompositeExistingWidgetRoute();
                  }));
            },
            child: Text('10.2 组合现有组件'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return CompositeExamplesRoute();
                  }));
            },
            child: Text('10.3 组合实例'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return CustomPaintWidgetRoute();
                  }));
            },
            child: Text('10.4 自绘组件 （CustomPaint与Canvas）'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return CustomPaintExamplesRoute();
                  }));
            },
            child: Text('10.5 自绘实例'),
          ),
        ],
      ),
    );
  }
}
