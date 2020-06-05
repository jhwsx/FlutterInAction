import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StatefullWidget Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
      home: CountWidget(),
//    home: Text('xxx'),
    );
  }
}

class CountWidget extends StatefulWidget {
  // 计数器的初始值
  final int initValue;

  const CountWidget({Key key, this.initValue = 0});

  @override
  State<StatefulWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  // 状态值
  int _counter;

  // 当 StatefulWidget 插入到 Widget 树时调用该方法
  // Framework 会为每一个它创建的 State 对象调用这个方法, 仅仅一次.
  // 通常在这里做一些一次性的操作.
  @override
  void initState() {
    super.initState();
    _counter = widget.initValue;
    print('initState');
  }

  // 用于构建 Widget 子树的
  // Framework 在几种不同的情况下会调用此方法:
  // * 在调用 initState 之后
  // * 在调用 didUpdateWidget 之后
  // * 在收到对 setState 的一个调用之后
  // * 在 State 对象的依赖改变之后
  // * After calling [deactivate] and then reinserting the [State] object into
  //   the tree at another location.
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('StatefulWidget Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                setState(() {
                  ++_counter;
                });
              },
              child: Text('$_counter'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FetchStateRoute();
                }));
              },
              child: Text(
                '子树中获取 State 对象',
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
                'Cupertino组件风格演示',
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
              child: Text('状态管理'),
              textColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // 当 widget 的配置发生改变时调用此方法
  // 覆写这个方法,确保要开始就调用 super.didUpdateWidget(oldWidget);
  // ：在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中
  // 同一位置的新旧节点，然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。
  @override
  void didUpdateWidget(CountWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  // 当 State 对象被从树上移除的时候调用此方法
  // 覆写此方法,确保最后调用 super.deactivate();
  // 如果移除后没有重新插入到树中则紧接着会调用dispose()方法。
  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  // 当 State 对象被永久从树上移除时调用此方法
  // 覆写此方法,确保最后调用 super.dispose();
  // 通常在这里释放资源.
  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  // 此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，
  // 此回调在Release模式下永远不会被调用。
  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  // 当 State 对象的依赖发生改变时调用此方法
  // 此方法在调用 initState 后会马上被调用
  // 典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

class FetchStateRoute extends StatelessWidget {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print('context1=$context');
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(title: Text('子树中获取 State 对象')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              // 如果没有 Builder, 那么 _scaffoldState 就是 null.
              return RaisedButton(
                onPressed: () {
                  // 查找父级最近的Scaffold对应的ScaffoldState对象
                  // 查找父级最近的 StatefulWidget 的类型为 ScaffoldState 的 State 对象
                  ScaffoldState _scaffoldState =
                      context.findAncestorStateOfType<ScaffoldState>();
                  // 调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
                  _scaffoldState.showSnackBar(
                      SnackBar(content: Text('我是 SnackBar 的内容 1')));
                },
                child: Text('显示 SnackBar 1'),
              );
            }),
            Builder(builder: (context) {
              // 如果没有 Builder, 那么 _scaffoldState 就是 null.
              print('context2=$context');
              return RaisedButton(
                onPressed: () {
                  // 直接通过of静态方法来获取ScaffoldState
                  ScaffoldState _scaffoldState = Scaffold.of(context);
                  print('context3=$context');
                  // 调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
                  _scaffoldState.showSnackBar(
                      SnackBar(content: Text('我是 SnackBar 的内容 2')));
                },
                child: Text('显示 SnackBar 2'),
              );
            }),
            RaisedButton(
              onPressed: () {
                //_globalKey.currentWidget;
                // 通过 GlobalKey 来获取 State 对象:
                ScaffoldState _scaffoldState = _globalKey.currentState;
                // 调用 ScaffoldState 的 showSnackBar 来弹出 SnackBar
                _scaffoldState
                    .showSnackBar(SnackBar(content: Text('我是 SnackBar 的内容 3')));
              },
              child: Text('显示 SnackBar 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Demo'),
      ),
      child: Center(
        child: CupertinoButton(
            child: Text('Press'),
            color: CupertinoColors.activeBlue,
            onPressed: () {}),
      ),
    );
  }
}

// 状态管理
class StateManagementRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('状态管理'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '1, Widget 管理自身状态:',
              style: TextStyle(color: Colors.blue[600], fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            TapboxA(),
            Text(
              '2, 父Widget管理子Widget的状态:',
              style: TextStyle(color: Colors.blue[600], fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            ParentWidgetB(),
            Text(
              '3, 混合状态管理:',
              style: TextStyle(color: Colors.blue[600], fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            ParentWidgetC(),
          ],
        ),
      ),
    );
  }
}

// Widget 管理自身的状态
class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TapboxAState();
  }
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}

// 父Widget管理子Widget的状态,告诉子 Widget 何时更新
class ParentWidgetB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentWidgetBState();
  }
}

class ParentWidgetBState extends State<ParentWidgetB> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxB(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapBoxB({Key key, this.active: false, this.onChanged}) : super(key: key);

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}

// 混合状态管理
// 子组件管理一些内部状态,父组件管理一些外部状态
// 本例子:父组件管理外部状态: active; 子组件管理内部状态: highlight.
class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() {
    return _ParentWidgetCState();
  }
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TapBoxC(
        active: _active,
        onChanged: _handleChanged,
      ),
    );
  }
}

class TapBoxC extends StatefulWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapBoxC({Key key, this.active, this.onChanged}) : super(key: key);

  @override
  _TapBoxCState createState() {
    return _TapBoxCState();
  }
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }
  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? Border.all(color: Colors.teal[700], width: 10.0)
                : null),
      ),
    );
  }
}

// TODO Builder 是什么作用?
// https://stackoverflow.com/questions/52088889/can-someone-explain-to-me-what-the-builder-class-does-in-flutter
