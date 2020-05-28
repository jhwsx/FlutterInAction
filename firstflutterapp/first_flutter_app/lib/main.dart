import 'package:flutter/material.dart'; // 导入包：导入了 Material UI 组件库

void main() { // 应用入口
  // runApp(Widget app) 的功能是启动 Flutter 应用
  // 方法解释：填充给定的控件并把它附加到屏幕上。
  // Widget 参数是 MyApp() 对象，MyApp() 是 Flutter 应用的根组件。
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Flutter在构建页面时，会调用组件的build方法，widget的主要工作是提供一个build()
  // 方法来描述如何构建UI界面（通常是通过组合、拼装其它基础widget）。
  @override
  Widget build(BuildContext context) {
    // MaterialApp 是 Material 库中提供的 Flutter App 框架。
    // 通过它可以设置应用的名称、主题、语言、首页及路由列表等。
    // MaterialApp 也是一个 widget，它继承了 StatefulWidget，
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // 主题色样：这里指定是蓝色。
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home 参数指定 Flutter 的首页，也是指定一个 Widget。
      // 测试发现，这个参数不指定，直接无法运行了。
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
// 首页 widget，继承自 StatefulWidget， 表示这是一个有状态的组件。
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  // 创建状态类：_MyHomePageState
  // framework 在 StatefulWidget 的生命周期里会多次调用此方法。
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 组件的状态，一个点击次数计数器
  int _counter = 0; // 记录按钮点击的次数
  // 设置状态的自增函数
  // 当按钮点击时，会调用此函数
  // 这个方法是先自增 _counter, 再调用 setState()
  // 调用 setState(),会通知 Flutter 框架，有状态发生了改变。Flutter 接收到通知后，会重新执行
  // build() 方法来根据新的状态来更新界面。如果不调用 setState() 方法，那么 build() 方法不会
  // 再次调用，那么什么也不会发生。
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  // build 方法里是构建 UI 界面的逻辑，当MyHomePage第一次创建时，_MyHomePageState类会被创建，
  // 当初始化完成后，Flutter框架会调用Widget的build方法来构建widget树，最终将widget树渲染到设备屏幕上。
  // 这个方法是由 framework 调用的
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // Scaffold 是 Material 库中提供的页面脚手架，它提供了默认的导航栏、标题和包含主屏幕widget
    // 树（后同“组件树”或“部件树”）的body属性，组件树可以很复杂。
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // TODO 这里的 widget 什么时候赋值的？
        title: Text(widget.title),
      ),
      // Center 是一个组件，Center 可以将其子组件树对齐到屏幕中心。
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column的作用是将其所有子组件沿屏幕垂直方向依次排列
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          // 指定 Column 的子组件：两个 Text
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', // 这个 Text 显示 _counter 状态的数值。
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // onPressed 属性接收了一个回调函数，就是上面定义的 _incrementCounter()方法。
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
// 流程：
// 当右下角的floatingActionButton按钮被点击之后，会调用_incrementCounter方法。
// 在_incrementCounter方法中，首先会自增_counter计数器（状态），然后setState会通知Flutter
// 框架状态发生变化，接着，Flutter框架会调用build方法以新的状态重新构建UI，最终显示在设备屏幕上。

// TODO 有状态的组件（Stateful widget） 和无状态的组件（Stateless widget）的不同
// TODO 为什么要将build方法放在State中，而不是放在StatefulWidget中？
