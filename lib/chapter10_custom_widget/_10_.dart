import 'package:flutter/material.dart';

import '_10_2_composite_existing_widget.dart';

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
        ],
      ),
    );
  }
}
