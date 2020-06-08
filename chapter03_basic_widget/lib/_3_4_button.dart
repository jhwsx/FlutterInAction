import 'package:flutter/material.dart';

class ButtonRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('按钮')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              // 漂浮按钮,有阴影和灰色背景；按压后,阴影会变大.
              onPressed: () {},
              child: Text('RaisedButton'),
            ),
            SizedBox(
              height: 4,
            ),
            FlatButton(
              // 扁平按钮,默认背景透明且不带背景,按压后,会有背景色.
              onPressed: () {},
              child: Text('FlatButton'),
            ),
            SizedBox(
              height: 4,
            ),
            OutlineButton(
              // 默认有一个边框,不带阴影且背景透明. 按压后,边框颜色变亮,同时出现背景和阴影.
              onPressed: () {},
              child: Text('OutlineButton'),
            ),
            SizedBox(
              height: 4,
            ),
            IconButton(
              // 是一个可点击的 icon, 不包括文字, 默认没有背景,点击后会出现背景.
              icon: Icon(Icons.access_alarm),
              onPressed: () {},
            ),
            SizedBox(
              height: 4,
            ),
            RaisedButton.icon(
              // 带图标的按钮
              onPressed: () {},
              icon: Icon(Icons.settings),
              label: Text('设置'),
            ),
            SizedBox(
              height: 4,
            ),
            FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text('添加'),
            ),
            SizedBox(
              height: 4,
            ),
            OutlineButton.icon(
              onPressed: () {},
              icon: Icon(Icons.delete),
              label: Text('删除'),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('自定义按钮'),
              color: Colors.blue,
              colorBrightness: Brightness.dark,
              highlightColor: Colors.blue[700],
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('自定义按钮'),
              color: Colors.blue,
              colorBrightness: Brightness.dark,
              highlightColor: Colors.blue[700],
              splashColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
