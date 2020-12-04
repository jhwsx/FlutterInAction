import 'package:flutter/material.dart';

// 学习 Padding 容器类组件
// 1, 给子组件添加补白
// 2, 属性就一个：final EdgeInsetsGeometry padding; EdgeInsetsGeometry 是一个抽象类，
// 一般使用它的子类 EdgeInsets， EdgeInsets 定义了设置填充的便捷方法。
// 3, 注意设置的 EdgeInsets 都有 const 这个关键字。
class PaddingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('填充（Padding）')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          Text(
            'Hello world',
            style: TextStyle(backgroundColor: Colors.red),
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          Padding(
            // 左边添加8像素的补白
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('Hello world',
                style: TextStyle(backgroundColor: Colors.blue)),
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Hello world',
              style: TextStyle(backgroundColor: Colors.yellow),
            ),
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Hello world',
              style: TextStyle(backgroundColor: Colors.yellow),
            ),
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Hello world',
              style: TextStyle(backgroundColor: Colors.lightBlue),
            ),
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
            child: Text(
              'Hello world',
              style: TextStyle(backgroundColor: Colors.lightBlue),
            ),
          ),
          Divider(
            height: 1.0,
            indent: 0.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
