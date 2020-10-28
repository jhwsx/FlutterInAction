import 'package:flutter/material.dart';

import '_3_1_cupertino_test.dart';
import '_3_1_get_state.dart';
import '_3_1_state_lifecycle.dart';
import '_3_2_state_management.dart';
import '_3_3_text_and_font.dart';
import '_3_4_button.dart';
import '_3_5_image_and_icon.dart';
import '_3_6_switch_and_checkbox.dart';
import '_3_7_textfield_and_form.dart';
import '_3_8_progress_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第三章 基础组件',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第三章 基础组件'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StateLifecycleRoute();
                }));
              },
              child: Text(
                '3.1 Widget 简介之 State 生命周期',
              ),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FetchStateRoute();
                }));
              },
              child: Text(
                '3.1 Widget 简介之子树中获取 State 对象',
              ),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CupertinoTestRoute();
                }));
              },
              child: Text(
                '3.1 Widget 简介之Cupertino组件风格演示',
              ),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StateManagementRoute();
                }));
              },
              child: Text('3.2 状态管理'),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TextFontRoute();
                }));
              },
              child: Text('3.3 文本字体样式'),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ButtonRoute();
                }));
              },
              child: Text('3.4 按钮'),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ImageIconRoute();
                }));
              },
              child: Text('3.5 图片及Icon'),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return SwitchAndCheckBoxRoute();
                }));
              },
              child: Text('3.6 单选开关和复选框'),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TextFieldAndFormRoute();
                }));
              },
              child: Text('3.7 输入框和表单'),
              textColor: Colors.blue,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProgressIndicatorRoute();
                }));
              },
              child: Text('3.8 进度指示器'),
              textColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
