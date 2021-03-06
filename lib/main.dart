import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter02_first_flutter_app/firstflutterapp.dart';
import 'package:flutter_in_action/chapter03_basic_widget/_3_.dart';
import 'package:flutter_in_action/chapter05_container_widget/_5_.dart';
import 'package:flutter_in_action/chapter06_scrollable_widget/_6_.dart';
import 'package:flutter_in_action/chapter07_functional_widget/_7_.dart';
import 'package:flutter_in_action/chapter09_animations/_9_.dart';
import 'package:flutter_in_action/chapter10_custom_widget/_10_.dart';
import 'package:flutter_in_action/chapter11_file_network/_11_.dart';

import 'chapter04_layout_widget/_4_.dart';
import 'chapter08_eventhandling_notification/_8_.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter In Action',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter In Action'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FirstFlutterApp();
              }));
            },
            child: Text("第二章：第一个 Flutter 应用"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Chapter3BasicWidgetRoute();
              }));
            },
            child: Text("第三章：基础组件"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Chapter04LayoutWidget();
              }));
            },
            child: Text("第四章：布局类组件"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Chapter05ContainerWidget();
              }));
            },
            child: Text("第五章: 容器类组件"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Chapter06ScrollableWidget();
              }));
            },
            child: Text("第六章：可滚动组件"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Chapter07FunctionalWidget();
              }));
            },
            child: Text("第七章：功能型组件"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Chapter08Widget();
              }));
            },
            child: Text("第八章：事件处理与通知"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return AnimationsRoute();
              }));
            },
            child: Text('第九章：动画'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return CustomWidgetRoute();
              }));
            },
            child: Text('第十章：自定义组件'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return FileNetworkRoute();
              }));
            },
            child: Text('第十一章：文件操作与网络请求'),
          ),
        ],
      ),
    );
  }
}
