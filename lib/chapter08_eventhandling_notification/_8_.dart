import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
