import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO 学习 Dart IO库操作文件的API
class FileOperationsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('11.1 文件操作'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return UsePathProviderRoute();
                }));
              },
              child: Text('使用 path provider 来回显操作计数'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return UseSharedPreferencesRoute();
                }));
              },
              child: Text('使用 shared preferences 来回显操作计数'),
            ),
          ],
        ));
  }
}

class UsePathProviderRoute extends StatefulWidget {
  @override
  _UsePathProviderRouteState createState() => _UsePathProviderRouteState();
}

class _UsePathProviderRouteState extends State<UsePathProviderRoute> {
  int _counter = 0;

  @override
  void initState() {
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
    super.initState();
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录 getApplicationDocumentsDirectory() 需要 path_provider 插件
    // 获取应用程序的文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      var file = await _getLocalFile();
      String content = await file.readAsString();
      return int.parse(content);
    } catch (e) {
      return 0;
    }
  }

  Future<File> _writeCounter() async {
    var file = await _getLocalFile();
    return await file.writeAsString('$_counter');
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _writeCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('使用 path provider 来回显操作计数'),
      ),
      body: Center(
        child: Text('$_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class UseSharedPreferencesRoute extends StatefulWidget {
  @override
  _UseSharedPreferencesRouteState createState() =>
      _UseSharedPreferencesRouteState();
}

class _UseSharedPreferencesRouteState extends State<UseSharedPreferencesRoute> {
  int _counter = 0;

  @override
  void initState() {
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
    super.initState();
  }

  Future<int> _readCounter() async {
    var prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt('counter') ?? 0;
    return counter;
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('使用 shared preferences 来回显操作计数'),
      ),
      body: Center(
        child: Text('$_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
