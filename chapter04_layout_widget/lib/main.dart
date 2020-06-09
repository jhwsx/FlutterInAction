import 'package:chapter04layoutwidget/_4_2_linear_layout_row_and_column.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第四章 布局类组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('第四章 布局类组件')),
      body: Column(
        children: [
          RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return RowAndColumnRoute();
            }));
          },
          child: Text('4.2 线性布局（Row和Column）'),)
        ],
      ),
    );
  }

}
