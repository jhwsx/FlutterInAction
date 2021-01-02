import 'package:flutter/material.dart';

class NotificationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("8.4 Notification"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NotificationListenerRoute();
              }));
            },
            child: Text("NotificationListener 之监听多个事件"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NotificationListenerSpecificNotificationRoute();
              }));
            },
            child: Text("NotificationListener 之指定通知类型"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CustomNotificationRoute();
              }));
            },
            child: Text("自定义 Notification"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CancelNotificationBubblingRoute();
              }));
            },
            child: Text("阻止冒泡"),
          ),
        ],
      ),
    );
  }
}

class NotificationListenerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationListener 之监听多个事件'),
      ),
      // typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);
      body: NotificationListener(
          // typedef NotificationListenerCallback<T extends Notification> = bool Function(T notification);
          onNotification: (notification) {
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                print('开始滚动');
                break;
              case ScrollUpdateNotification:
                print('正在滚动');
                break;
              case ScrollEndNotification:
                print('停止滚动');
                break;
              case OverscrollNotification:
                print('滚动到边界');
                break;
              default:
            }
            // 允许继续通知冒泡
            return false;
          },
          child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              })),
    );
  }
}

class NotificationListenerSpecificNotificationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationListener 之指定通知类型'),
      ),
      // typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);
      body: NotificationListener<ScrollEndNotification>(
          // typedef NotificationListenerCallback<T extends Notification> = bool Function(T notification);
          onNotification: (notification) {
            print('停止滚动');
            return false;
          },
          child: ListView.builder(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                );
              })),
    );
  }
}

class CustomNotificationRoute extends StatefulWidget {
  @override
  _CustomNotificationRouteState createState() =>
      _CustomNotificationRouteState();
}

class _CustomNotificationRouteState extends State<CustomNotificationRoute> {
  var _msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义 Notification"),
      ),
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + " ";
          });
          return false;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_msg),
              // 代码中注释的部分是不能正常工作的，因为这个context是根Context，
              // 而 NotificationListener 是监听的子树，所以我们通过Builder来构建 ElevatedButton，来获得按钮位置的context。
              // The notification will be delivered to any [NotificationListener] widgets
              // with the appropriate type parameters that are ancestors of the given
              // [BuildContext]. 通知会发送给是给定的 BuildContext 的父节点的 NotificationListener。
              // ElevatedButton(
              //   onPressed: () {
              //     MyNotification("Hello").dispatch(context);
              //   },
              //   child: Text('Post Notification'),
              // ),
              Builder(builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    MyNotification("Hello").dispatch(context);
                  },
                  child: Text('Post Notification'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


class CancelNotificationBubblingRoute extends StatefulWidget {
  @override
  _CancelNotificationBubblingRouteState createState() =>
      _CancelNotificationBubblingRouteState();
}

class _CancelNotificationBubblingRouteState extends State<CancelNotificationBubblingRoute> {
  var _msg = '';
  bool _cancelBubbling = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("阻止冒泡"),
      ),
      body: NotificationListener<MyNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + "-";
          });
          return false;
        },
        child: NotificationListener<MyNotification>(
          onNotification: (notification) {
            setState(() {
              _msg += notification.msg + "=";
            });
            // 返回 true，则阻止冒泡，那么外层的 NotificationListener 收不到通知；
            // 返回 false，则不阻止冒泡，那么内层和外层的 NotificationListener 都可以收到通知。
            return _cancelBubbling;
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                  Text("是否阻止冒泡？"),
                  Switch(value: _cancelBubbling, onChanged: (value) {
                    setState(() {
                      _cancelBubbling = value;
                    });
                  }),
                ],),
                Text(_msg),
                Builder(builder: (BuildContext context) {
                  return ElevatedButton(
                    onPressed: () {
                      MyNotification("Hello").dispatch(context);
                    },
                    child: Text('Post Notification'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}
