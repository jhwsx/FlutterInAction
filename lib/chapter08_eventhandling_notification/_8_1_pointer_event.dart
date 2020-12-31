import 'package:flutter/material.dart';

// Flutter 中使用 Listener 监听原始触摸事件。
class PointerEventRoute extends StatefulWidget {
  @override
  _PointerEventRouteState createState() => _PointerEventRouteState();
}

class _PointerEventRouteState extends State<PointerEventRoute> {
  PointerEvent _event;
  bool toggle = true;
  HitTestBehavior _selectValue = HitTestBehavior.deferToChild;

  _onToggleChanged(bool value) {
    setState(() {
      toggle = value;
    });
  }

  _onSelectBehaviorChanged(HitTestBehavior value) {
    setState(() {
      _selectValue = value;
    });
  }

  _onPointer(PointerEvent event) {
    setState(() {
      // delta：Offset 对象，两次指针移动事件的距离。都为负数，表示向左上角移动。
      // pressure: 按压力度。
      // orientation: 指针移动方向，是一个角度值。TODO 为什么一直是 0？
      print(
          'event=$event, delta=${event.delta}, pressure=${event.pressure}, orientation=${event.orientation}');
      _event = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('8.1 原始指针事件处理'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("是否显示 Container 背景色？"),
                Switch(value: toggle, onChanged: _onToggleChanged),
              ],
            ),
            ListTile(
              title: Text("behavior"),
              trailing: DropdownButton(
                value: _selectValue,
                items: <DropdownMenuItem<HitTestBehavior>>[
                  DropdownMenuItem(
                    child: Text(HitTestBehavior.deferToChild.toString()),
                    value: HitTestBehavior.deferToChild,
                  ),
                  DropdownMenuItem(
                    child: Text(HitTestBehavior.opaque.toString()),
                    value: HitTestBehavior.opaque,
                  ),
                  DropdownMenuItem(
                    child: Text(HitTestBehavior.translucent.toString()),
                    value: HitTestBehavior.translucent,
                  ),
                ],
                onChanged: _onSelectBehaviorChanged,
              ),
            ),
            Text("手指在蓝色区域内移动可以查看当前指针变化, "
                "behavior 为 deferToChild，当有背景色时，在蓝色区域内都有事件响应；当没有背景色时，只在文本上才有事件响应。\n"
                "behavior 为 opaque 或 translucent，无论是否有背景色，在区域内都有事件响应。"),
            Listener(
              child: Container(
                alignment: Alignment.center,
                color: toggle ? Colors.blue : null,
                height: 150,
                child: Text(
                  _event?.toString() ?? "init text",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              behavior: _selectValue,
              onPointerDown: (PointerDownEvent event) => _onPointer(event),
              onPointerMove: (PointerMoveEvent event) => _onPointer(event),
              onPointerUp: (PointerUpEvent event) => _onPointer(event),
            ),
            Text("translucent，当点击组件透明区域时，可以对自身透明区域内以及底部可视区域都进行命中测试，"
                "也就是说，点击顶部组件透明区域时，顶部组件和底部组件都可以接收到事件。"
                "这种情况下，deferToChild, 顶部组件没有接收到事件，只有底部组件接收到；"
                "opaque，顶部组件接收到事件，底部组件没有接收到事件，这是因为 opaque 时将当前组件当成不透明处理了。"),
            Wrap(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Listener(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.blue,
                      ),
                      onPointerDown: (PointerDownEvent event) =>
                          print('onPointerDown 底部'),
                    ),
                    Listener(
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                      ),
                      behavior: _selectValue,
                      onPointerDown: (PointerDownEvent event) =>
                          print("onPointerDown 顶部"),
                    ),
                  ],
                ),
                Text("底部蓝色区域是底部组件，顶部是透明区域，大小是底部区域的左上1/4部分。"),
              ],
            ),
            Text("忽略 PointerEvent：使用 AbsorbPointer（absorb：吸收）, 可以不让子树响应 PointerEvent，"
                "但是 AbsorbPointer 本身会参与命中测试。"),
            // 会输出 up，不会输出 in
            Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    width: 200,
                    height: 200,
                    color:Colors.red,
                  ),
                  onPointerDown: (PointerDownEvent event) => print("in"),
                ),
              ),
              onPointerDown: (PointerDownEvent event) => print("up"),
            ),
            Text("忽略 PointerEvent：使用 IgnorePointer 可以不让子树响应 PointerEvent，"
                "但是 IgnorePointer 本身不会参与命中测试。"),
            // 不会输出 up，不会输出 in
            Listener(
              child: IgnorePointer(
                child: Listener(
                  child: Container(
                    width: 200,
                    height: 200,
                    color:Colors.red,
                  ),
                  onPointerDown: (PointerDownEvent event) => print("in"),
                ),
              ),
              onPointerDown: (PointerDownEvent event) => print("up"),
            ),
          ],
        ),
      ),
    );
  }
}
// 手指按下后迅速抬起，打印了一个 down，多个 move，一个 up。Android 上不会由 move 事件的。
// I/flutter (20456): event=PointerDownEvent#2e1e3(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#7198d(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#9e007(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#39310(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#8ac3f(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#fc778(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#31261(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#fcc5e(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#1fdb7(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerMoveEvent#bce10(position: Offset(258.3, 229.0))
// I/flutter (20456): event=PointerUpEvent#82f17(position: Offset(258.3, 229.0))
