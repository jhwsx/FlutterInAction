import 'package:chapter05containerwidget/_5_1_padding.dart';
import 'package:chapter05containerwidget/_5_2_size_constrained_container.dart';
import 'package:chapter05containerwidget/_5_3_decorated_box.dart';
import 'package:chapter05containerwidget/_5_4_transform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第五章 容器类组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '第五章 容器类组件'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SizeConstrainedContainerRoute();
            }));
          },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
          child: Text('5.2 尺寸限制类容器'),),
          RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DecoratedBoxRoute();
            }));
          },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.3 装饰容器DecoratedBox'),), RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return TransformRoute();
            }));
          },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('5.4 变换（Transform）'),),
        ],
      ),
    );
  }
}
