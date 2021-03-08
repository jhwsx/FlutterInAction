import 'dart:ui';

import 'package:flutter/material.dart';

class ColorThemeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("7.4 颜色和主题"),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ConvertColorStringRoute();
              }));
            },
            child: Text("将颜色字符串转成Color对象"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ColorLuminanceRoute();
              }));
            },
            child: Text("颜色亮度"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ThemeTestRoute();
              }));
            },
            child: Text("主题测试"),
          ),
        ],
      ),
    );
  }
}

class ConvertColorStringRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("将颜色字符串转成Color对象"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "Color(0xffdc380d)",
            style: TextStyle(
              color: Color(0xffdc380d),
            ),
          ),
          Text(
            "通过为运算将 Alpha 值设置为 FF",
            style: TextStyle(
              color: Color(int.parse(
                    "dc380d",
                    radix: 16,
                  ) |
                  0xFF000000),
            ),
          ),
          Text(
            "通过方法将Alpha设置为FF",
            style: TextStyle(
              color: Color(
                int.parse(
                  "dc380d",
                  radix: 16, // 设置基数
                ),
              ).withAlpha(255),
            ),
          ),
        ],
      ),
    );
  }
}

// 实现一个背景颜色和Title可以自定义的导航栏，并且背景色为深色时我们应该让Title显示为浅色；背景色为浅色时，Title显示为深色。
class ColorLuminanceRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("颜色亮度"),
      ),
      body: Column(
        children: <Widget>[
          NavBar(
            title: "标题",
            color: Colors.blue,
          ),
          SizedBox(
            height: 16,
          ),
          NavBar(
            title: "标题",
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  NavBar({Key key, this.title, this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52.0,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color.computeLuminance() < 0.5
              ? Colors.white
              : Colors.blue, // luminance: 亮度。
        ),
      ),
      alignment: Alignment.center,
    );
  }
}

// ThemeData 保存了 Material 组件库的主题数据。Material 组件需要遵守相应的设计规范，而这些规范可
// 自定义的部分都定义在了 ThemeData 里面，所以可以通过 ThemeData 来自定义应用主题。
// 在子组件里面，可以通过 Theme.of 方法来获取当前的 ThemeData。
class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor, // 用于导航栏，FAB 的背景色等
        iconTheme: IconThemeData(color: _themeColor), // 用于 Icon 颜色
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("主题测试"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                SizedBox(
                  width: 8,
                ),
                Text("颜色跟随主题"),
              ],
            ),
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  SizedBox(
                    width: 8,
                  ),
                  Text("颜色固定黑色"),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themeColor =
                  _themeColor == Colors.teal ? Colors.blue : Colors.teal;
            });
          },
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}
