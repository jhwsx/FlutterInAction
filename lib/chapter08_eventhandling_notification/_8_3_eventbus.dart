import 'package:flutter/material.dart';

class EventBusRoute extends StatefulWidget {
  @override
  _EventBusRouteState createState() => _EventBusRouteState();
}

class _EventBusRouteState extends State<EventBusRoute> {
  var _textValue = "";

  @override
  void initState() {
    bus.register('event', (v) {
      setState(() {
        _textValue = 'Event value is $v';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    bus.unregister('event');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('8.3 事件总线'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_textValue),
            ElevatedButton(
              onPressed: () {
                // typedef WidgetBuilder = Widget Function(BuildContext context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return PostEventRoute();
                }));
              },
              child: Text("Open Post Event Route"),
            )
          ],
        ),
      ),
    );
  }
}

class PostEventRoute extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发送事件页面"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
            ),
            ElevatedButton(
              onPressed: () {
                bus.postEvent('event', _controller.text);
              },
              child: Text('Post Event'),
            ),
          ],
        ),
      ),
    );
  }
}

/// EventBus 的实现
// 订阅者回调签名
typedef void EventCallback(v);

class EventBus {
  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  EventBus._internal();

  /// 饿汉式
  static EventBus _singleton = EventBus._internal();

  /// 工厂构造方法
  factory EventBus() => _singleton;

  /// 保存订阅事件队列，key: 事件名字，value: 事件的订阅者序列
  var _emap = Map<Object, List<EventCallback>>();

  /// 注册订阅者
  void register(eventName, EventCallback callback) {
    if (eventName == null || callback == null) return;
    // ??= 这个叫做 Null-aware 赋值操作符
    _emap[eventName] ??= [];
    _emap[eventName].add(callback);
  }

  /// 注销订阅者
  /// 这里 [] 使用的是位置参数。
  void unregister(eventName, [EventCallback callback]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (callback == null) {
      _emap[eventName] = null;
    } else {
      list.remove(callback);
    }
  }

  /// 发送事件
  void postEvent(eventName, [v]) {
    var list = _emap[eventName];
    if (list == null) return;
    int size = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (int i = size; i >= 0; i--) {
      list[i](v);
    }
  }
}

/// 定义一个全局变量，这样页面引入该文件后就可以直接使用 EventBus 了。
var bus = EventBus();
