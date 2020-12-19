import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_1_will_pop_scope.dart';

class Chapter07FunctionalWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第七章：功能型组件"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WillPopScopeTestRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('7.1 导航返回拦截（WillPopScope）'),
          ),
        ],
      ),
    );
  }
}
