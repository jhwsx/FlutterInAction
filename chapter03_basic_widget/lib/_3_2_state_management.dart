import 'package:flutter/material.dart';
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
  // 外部状态
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
  // 内部状态
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