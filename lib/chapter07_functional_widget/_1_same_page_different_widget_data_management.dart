import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// https://xuyisheng.top/flutter_state_management1/
// 通过 ValueNotifier，我们将每个可能因为共享数据的变化而改变的 Widget，封装起来，从而在数据改变的时候，只更新监听了该数据的 Widget。
class ValueNotifierWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ValueNotifierWidgetState();
}

class _ValueNotifierWidgetState extends State<ValueNotifierWidget> {
  ValueNotifier<String> _valueNotifier = ValueNotifier('Init String Data');
  PersonNotifier _customNotifier = PersonNotifier(People());
  ValueNotifier<int> _notifier = ValueNotifier(0);
  int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //     _notifier.value++;
  //   });
  // }

  void _incrementCounter() {
    // _counter 的变化不会显示在 ui 上，因为没有使用 setState 方法。
    _counter++;
    // _notifier.value 的变化会显示在 ui 上，因为它是由 ValueListenableBuilder 管理的数据。
    _notifier.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '同页面跨Widget数据管理',
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            NotifierWidget(data: _valueNotifier),
            ElevatedButton(
              onPressed: () {
                _valueNotifier.value = 'New Value ${Random().nextInt(100)}';
              },
              child: Text('Change'),
            ),
            CustomNotifierWidget(
              valueNotifier: _customNotifier,
            ),
            ElevatedButton(
              onPressed: () {
                _customNotifier.changePeople();
              },
              child: Text('Change'),
            ),
            ValueListenableBuilder(
                valueListenable: _notifier,
                builder: (BuildContext context, int value, Widget child) {
                  return Text(
                    'Number: $value',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  );
                }),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter();
              },
              child: Text('Change'),
            ),
            UnChangedWidget(),
          ],
        ),
      ),
    );
  }
}

class NotifierWidget extends StatefulWidget {
  final ValueNotifier<String> data;

  NotifierWidget({this.data});

  @override
  State<StatefulWidget> createState() => _NotifierWidgetState();
}

class _NotifierWidgetState extends State<NotifierWidget> {
  String info;

  @override
  void initState() {
    widget.data.addListener(_changeNotifier);
    info = '${widget.data.value}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('_NotifierWidgetState build()');
    return Text(
      info,
      style: TextStyle(fontSize: 30),
    );
  }

  @override
  void dispose() {
    widget.data.removeListener(_changeNotifier);
    super.dispose();
  }

  void _changeNotifier() {
    setState(() {
      info = '${widget.data.value}';
    });
  }
}

class CustomNotifierWidget extends StatefulWidget {
  final ValueNotifier<People> valueNotifier;

  const CustomNotifierWidget({Key key, this.valueNotifier}) : super(key: key);

  @override
  _CustomNotifierWidgetState createState() => _CustomNotifierWidgetState();
}

class _CustomNotifierWidgetState extends State<CustomNotifierWidget> {
  People info;

  @override
  void initState() {
    widget.valueNotifier.addListener(changeNotifier);
    info = widget.valueNotifier.value;
    super.initState();
  }

  @override
  void dispose() {
    widget.valueNotifier.removeListener(changeNotifier);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_CustomNotifierWidgetState build()');
    return Text(
      '${info.name} ${info.age}',
      style: TextStyle(fontSize: 30),
    );
  }

  void changeNotifier() {
    setState(() {
      info = widget.valueNotifier.value;
    });
  }
}

class People {
  String name = WordPair.random().toString();
  int age = Random().nextInt(100);
}

class PersonNotifier extends ValueNotifier<People> {
  PersonNotifier(People value) : super(value);

  void changePeople() {
    value.name = WordPair.random().toString();
    value.age = Random().nextInt(100);
    notifyListeners();
  }
}

class UnChangedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('UnChangedWidget build()');
    return Text(
      'UnChanged Text',
      style: TextStyle(fontSize: 30),
    );
  }
}
