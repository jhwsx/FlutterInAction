import 'package:flutter/material.dart'; // 导入包：导入了 Material UI 组件库
import 'package:english_words/english_words.dart';

void main() {
  // 应用入口
  // runApp(Widget app) 的功能是启动 Flutter 应用
  // 方法解释：填充给定的控件并把它附加到屏幕上。
  // Widget 参数是 MyApp() 对象，MyApp() 是 Flutter 应用的根组件。
  runApp(MyApp());
  // TODO 这里为什么不能打印?
  FlutterError.onError = (FlutterErrorDetails details) {
    print('自己上报异常: ${details.toString()}');
  };
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
      // 这里是在注册路由表，就是一个map。
      routes: {
        "tip": (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments),
      },
      // home 参数指定 Flutter 的首页，也是指定一个 Widget。
      // 测试发现，这个参数不指定，直接无法运行了。
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 演示 MaterialApp 的 initialRoute 的使用
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/", // 该属性决定应用的初始路由页是哪一个命名路由。
      // 这里是在注册路由表，就是一个map。
      routes: {
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'), // 注册首页路由
        "tip": (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments)
      },
    );
  }
}

// 演示 MaterialApp 的 onGenerateRoute 属性
class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/", // 该属性决定应用的初始路由页是哪一个命名路由。
      // 它在打开命名路由时可能会被调用，之所以说可能，是因为当调用Navigator.pushNamed(...)
      // 打开命名路由时，如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；
      // 如果路由表中没有注册，才会调用onGenerateRoute来生成路由。
      // 注意，onGenerateRoute只会对命名路由生效。
      onGenerateRoute: (RouteSettings settings) {
        print('===>onGenerateRoute');
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(title: 'Flutter Demo Home Page'));
          case 'tip':
            return MaterialPageRoute(
                builder: (context) => TipRoute(text: settings.arguments));
          default:
            throw Exception('unknown name');
        }
      },
    );
  }
}

class ContextRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Context测试'),
      ),
      body: Container(
        child: Builder(builder: (context) {
          // 在 Widget 树中向上查找最近的父级 Scaffold widget
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();
          // 这里返回的是 appBar 的 title,
          return (scaffold.appBar as AppBar).title;
        }),
      ),
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

        // widget 的初始化: This property is initialized by the framework before calling [initState].
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
            // 添加一个按钮
            FlatButton(
              child: Text('演示打开新路由'),
              textColor: Colors.blue,
              onPressed: () {
                // 当点击按钮时，导航到新路由
                // MaterialPageRoute 继承自 PageRoute 类，
                // PageRoute 类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，它还定义了路由构建及切换时过渡动画的相关接口及属性。
                // MaterialPageRoute 是 Material 库提供的组件，它可以针对不同平台，实现与平台页面切换动画风格一致的路由切换动画。
                /*
                 MaterialPageRoute({
                    @required this.builder,
                    RouteSettings settings,
                    this.maintainState = true,
                    bool fullscreenDialog = false,
                  })
                  第一个参数是 WidgetBuilder builder, 是一个必须要的可选命名参数，是一个 WidgetBuilder 类型的回调函数，定义如下：
                  typedef WidgetBuilder = Widget Function(BuildContext context);
                  它的作用是构建路由页面的具体内容，返回值是一个 widget。我们通常要实现此回调，返回新路由的实例。
                  第二个参数是 RouteSettings settings，包含路由的配置信息，如路由名称，传递给路由的参数，是否初始路由
                  第三个参数是 bool maintainState，默认值是 true，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置maintainState为false。
                  第四个参数是 bool fullscreenDialog，默认值是 false，表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）。
                 */
                // Navigator 是一个路由管理组件，它继承了 StatefulWidget。它提供了打开和退出路由的方法。
                // Navigator 通过一个栈来管理活动路由集合。通常当前屏幕显示的页面就是栈顶的路由。
                // bool pop(BuildContext context, [ result ])
                // 将栈顶路由出栈，result为页面关闭时返回给上一个页面的数据。
                // push 是 Navigator 的静态方法：将给定的路由入栈（即打开新的页面），返回值是一个Future对象，用以接收新路由出栈（即关闭）时的返回数据。
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return NewRoute();
                }));
              },
            ),
            RaisedButton(
              onPressed: () async {
                // 因为 Navigator.push 是异步函数，返回一个 Future 对象，
                // 要获取 Future 的结果，就要在异步函数之前加 await。
                // 同时函数体前面加上 async。
                // 获取到就是 NewRoute 点击按钮，把自己出栈时传递给 Navigator.pop 的值。
                // 点击 back 键 或者返回箭头获取到的值是 null。
                var result = await Navigator.push<String>(context,
                    MaterialPageRoute(builder: (context) {
                  return new TipRoute(text: '我是提示xxx');
                }));
//                var result = await Navigator.of(context).pushNamed('tip', arguments: 'hi');
                print('路由返回值：$result');
              },
              child: Text('演示打开新路由并传值以及从新路由获取返回数据'),
            ),
            RaisedButton(
              onPressed: () async {
                // 因为 Navigator.push 是异步函数，返回一个 Future 对象，
                // 要获取 Future 的结果，就要在异步函数之前加 await。
                // 同时函数体前面加上 async。
                // 获取到就是 NewRoute 点击按钮，把自己出栈时传递给 Navigator.pop 的值。
                // 点击 back 键 或者返回箭头获取到的值是 null。
                // 打开命名路由并传参
                var result = await Navigator.of(context)
                    .pushNamed('tip', arguments: 'hi');
                print('命名路由返回值：$result');
              },
              child: Text('演示通过路由名打开新路由并传值以及从新路由获取返回数据'),
            ),
            RandomWordsWidget(),
            RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AssetWidget();
                  }));
                },
                child: Text('资源管理')),
            RaisedButton(
              onPressed: () {
//              throw HttpException('http exception');
                throw Error();
              },
              child: Text('抛出一个异常'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ContextRoute();
                }));
              },
              child: Text('Context 测试'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        // onPressed 属性接收了一个回调函数，就是上面定义的 _incrementCounter()方法。
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 创建一个新的路由，相当于是一个新的 Activity。
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New route'),
      ),
      // Center 将子组件对齐到屏幕的中心
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }
}

// 创建一个 TipRoute 路由，它接受一个提示文本参数，负责将传入它的文本显示在页面上，另外TipRoute中
// 我们添加一个“返回”按钮，点击后在返回上一个路由的同时会带上一个返回参数。
class TipRoute extends StatelessWidget {
  final String text;

  TipRoute({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        // 内边距
        padding: EdgeInsets.all(18),
        child: Center(
          // 纵向排列
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text),
              RaisedButton(
                // 点击按钮，把当前的 Route 出栈
                // bool pop(BuildContext context, [ result ])
                // 将栈顶路由出栈，result为页面关闭时返回给上一个页面的数据。
                onPressed: () => Navigator.pop<String>(context, '我是返回值'),
                child: Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(wordPair.toString()),
    );
  }
}

class AssetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO 怎么加载?
//    var assetBundle = DefaultAssetBundle.of(context);
//    var info = await  assetBundle.loadString('assets/info.json');

    return Scaffold(
      appBar: AppBar(title: Text('资源管理')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/dog.jpeg'),
          ],
        ),
      ),
    );
  }
}

// 流程：
// 当右下角的floatingActionButton按钮被点击之后，会调用_incrementCounter方法。
// 在_incrementCounter方法中，首先会自增_counter计数器（状态），然后setState会通知Flutter
// 框架状态发生变化，接着，Flutter框架会调用build方法以新的状态重新构建UI，最终显示在设备屏幕上。

// TODO 有状态的组件（Stateful widget） 和无状态的组件（Stateless widget）的不同
// TODO 为什么要将build方法放在State中，而不是放在StatefulWidget中？
// TODO 什么是命名路由？
// 所谓“命名路由”（Named Route）即有名字的路由，我们可以先给路由起一个名字，然后就可以通过路由名字直接打开新的路由了，这为路由管理带来了一种直观、简单的方式。
// TODO 路由表
/*
要想使用命名路由，我们必须先提供并注册一个路由表（routing table），这样应用程序才知道哪个名字与哪个路由组件相对应。其实注册路由表就是给路由起名字，路由表的定义如下：
// routes 属性是 MaterialApp 的一个属性
Map<String, WidgetBuilder> routes;

它是一个Map，key为路由的名字，是个字符串；value是个builder回调函数，用于生成相应的路由widget。我们在通过路由名字打开新路由时，
应用会根据路由名字在路由表中查找到对应的WidgetBuilder回调函数，然后调用该回调函数生成路由widget并返回。
 */
// TODO 获取 AssetBundle 的两种方式
// TODO Dart单线程模型
