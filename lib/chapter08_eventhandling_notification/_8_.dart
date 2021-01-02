import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter08_eventhandling_notification/_8_2_gesture.dart';

import '_8_1_pointer_event.dart';

class Chapter08Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第八章：事件处理与通知"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PointerEventRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('8.1 原始指针事件处理'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GestureRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('8.2 手势识别'),
          ),
        ],
      ),
    );
  }
}
