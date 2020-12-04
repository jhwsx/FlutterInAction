import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_5_1_padding.dart';
import '_5_2_size_constrained_container.dart';
import '_5_3_decorated_box.dart';
import '_5_4_transform.dart';
import '_5_5_container.dart';
import '_5_6_scaffold_tabbar_bottomnavi.dart';
import '_5_7_clip.dart';

class Chapter05ContainerWidget extends StatefulWidget {
  Chapter05ContainerWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Chapter05ContainerWidgetState createState() => _Chapter05ContainerWidgetState();
}

class _Chapter05ContainerWidgetState extends State<Chapter05ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第五章: 容器类组件'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaddingRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.1 填充（Padding）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SizeConstrainedContainerRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.2 尺寸限制类容器'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DecoratedBoxRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.3 装饰容器DecoratedBox'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TransformRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.4 变换（Transform）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ContainerRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.5 Container（容器）'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScaffoldTabBarBottomNaviRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.6 Scaffold、TabBar、底部导航'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ClipRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.7 剪裁（Clip）'),
          ),
        ],
      ),
    );
  }
}
