import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_1_will_pop_scope.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_2_inherited_widget.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_3_provider.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_4_color_theme.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_5_future_builder_stream_builder.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_6_dialog.dart';

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
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InheritedWidgetRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('7.2 数据共享（InheritedWidget）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProviderRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('7.3 跨组件状态共享（Provider）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ColorThemeRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('7.4 颜色和主题'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FutureBuilderAndStreamBuilderRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('7.5 异步UI更新（FutureBuilder、StreamBuilder）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DialogRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('7.6 对话框详解'),
          ),
        ],
      ),
    );
  }
}
