import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter08_eventhandling_notification/_8_2_gesture.dart';
import 'package:flutter_in_action/chapter08_eventhandling_notification/_8_3_eventbus.dart';
import 'package:flutter_in_action/chapter08_eventhandling_notification/_8_4_notification.dart';

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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PointerEventRoute();
              }));
            },
            child: Text('8.1 原始指针事件处理'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GestureRoute();
              }));
            },
            child: Text('8.2 手势识别'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EventBusRoute();
              }));
            },
            child: Text('8.3 事件总线'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NotificationRoute();
              }));
            },
            child: Text('8.4 Notification'),
          ),
        ],
      ),
    );
  }
}
