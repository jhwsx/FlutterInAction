import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FutureBuilderAndStreamBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('7.5 异步UI更新（FutureBuilder、StreamBuilder）'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FutureBuilderRoute();
              }));
            },
            child: Text('FutureBuilder'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StreamBuilderRoute();
              }));
            },
            child: Text('StreamBuilder'),
          ),
        ],
      ),
    );
  }
}

class FutureBuilderRoute extends StatelessWidget {
  var future = mockNetworkData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          // future: FutureBuilder 依赖的 Future，通常是一个异步耗时任务。
          future: future,
          // typedef AsyncWidgetBuilder<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);
          // Widget构建器；该构建器会在Future执行的不同阶段被多次调用
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            // snapshot 会包含当前任务的状态信息以及结果信息
            if (snapshot.connectionState == ConnectionState.done) {
              // 请求已结束
              if (snapshot.hasError) {
                // 请求失败，显示错误页面
                return Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                );
              } else {
                // 请求成功，显示成功页面
                return Text(
                  "Contents: ${snapshot.data}",
                );
              }
            } else {
              // 请求还在进行中
              return CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(Colors.green),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<String> mockNetworkData() async {
  if (Random().nextBool()) {
    return Future.delayed(Duration(seconds: 2), () => "这是从网络上获取到的数据。");
  } else {
    return Future.delayed(
        Duration(seconds: 2), () => throw AsyncError("Server Bang.", null));
  }
}

class StreamBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StreamBuilder'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: counter(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError) {
              return Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: Colors.red, fontSize: 18),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("没有 Stream");
              case ConnectionState.waiting:
                return Text("等待数据...");
              case ConnectionState.active: // 只有 StreamBuilder 有这个状态。
                return Text("active: ${snapshot.data}");
              case ConnectionState.done:
                return Text("Stream 已关闭");
            }
            return null;
          },
        ),
      ),
    );
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    if (i >= 10) {
      throw StateError("Server Bang!!!");
    }
    return i;
  });
}
