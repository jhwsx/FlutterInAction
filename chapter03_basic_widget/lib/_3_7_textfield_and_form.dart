import 'package:flutter/material.dart';

// 知识点:
// 输入框组件: TextField
// 表单组件: Form
class TextFieldAndFormRoute extends StatefulWidget {
  @override
  _TextFieldAndFormRouteState createState() => _TextFieldAndFormRouteState();
}

class _TextFieldAndFormRouteState extends State<TextFieldAndFormRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('输入框和表单')),
      body: TextField(),
    );
  }
}
