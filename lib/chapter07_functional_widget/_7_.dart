import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_1_same_page_different_widget_data_management.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_1_will_pop_scope.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_2_inherited_widget.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_3_provider.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_4_color_theme.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_5_future_builder_stream_builder.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_6_dialog.dart';
import 'package:flutter_in_action/chapter08_eventhandling_notification/_8_4_notification.dart';

import '_3_bloc.dart';

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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WillPopScopeTestRoute();
              }));
            },
            child: Text('7.1 导航返回拦截（WillPopScope）'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return InheritedWidgetRoute();
              }));
            },
            child: Text('7.2 数据共享（InheritedWidget）'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProviderRoute();
              }));
            },
            child: Text('7.3 跨组件状态共享（Provider）'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ColorThemeRoute();
              }));
            },
            child: Text('7.4 颜色和主题'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FutureBuilderAndStreamBuilderRoute();
              }));
            },
            child: Text('7.5 异步UI更新（FutureBuilder、StreamBuilder）'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DialogDemoRoute();
              }));
            },
            child: Text('7.6 对话框详解'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ValueNotifierWidget();
              }));
            },
            child: Text('同页面跨Widget数据管理之ValueNotifier'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NotificationRoute();
              }));
            },
            child: Text('同页面跨Widget数据管理之Notification'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BLoCWidget();
              }));
            },
            child: Text('跨页面跨Widget数据管理之BLoC'),
          ),
        ],
      ),
    );
  }
}
