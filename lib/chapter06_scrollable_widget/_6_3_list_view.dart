import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ListViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ListViewDefaultConstructorRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text("默认构造函数"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ListViewBuilderRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text("ListView.builder"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ListViewSeparatedRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text("ListView.separated"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return HorizontalListViewRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text("横向的ListView"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return LoadMoreListViewRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text("实例：加载更多列表"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FixedHeaderListViewRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text("实例：固定列表头的ListView"),
          ),
        ],
      ),
    );
  }
}

class ListViewDefaultConstructorRoute extends StatefulWidget {
  @override
  _ListViewDefaultConstructorState createState() =>
      _ListViewDefaultConstructorState();
}

class _ListViewDefaultConstructorState
    extends State<ListViewDefaultConstructorRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("默认构造函数"),
      ),
      body: ListView(
        shrinkWrap: false,
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          const Text(
            "Title1",
            textScaleFactor: 5,
          ),
          const Text(
            "Title2",
            textScaleFactor: 5,
          ),
          const Text(
            "Title3",
            textScaleFactor: 5,
          ),
          const Text(
            "Title4",
            textScaleFactor: 5,
          ),
          const Text(
            "Title5",
            textScaleFactor: 5,
          ),
          const Text(
            "Title6",
            textScaleFactor: 5,
          ),
          const Text(
            "Title7",
            textScaleFactor: 5,
          ),
          const Text(
            "Title8",
            textScaleFactor: 5,
          ),
          const Text(
            "Title9",
            textScaleFactor: 5,
          ),
          const Text(
            "Title10",
            textScaleFactor: 5,
          ),
        ],
      ),
    );
  }
}

class ListViewBuilderRoute extends StatefulWidget {
  @override
  _ListViewBuilderState createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView.builder"),
      ),
      body: ListView.builder(
          // 列表项的数量，如果为 null，则为无限列表
          itemCount: null,
          // 滚动方向上子组件的长度。在ListView中，指定itemExtent比让子组件自己决定自
          // 身长度会更高效，这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，
          // 而无需每次构建子组件时都去再计算一下，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。
          itemExtent: 50,
          shrinkWrap: true,
          // 列表项的构建器，类型是IndexedWidgetBuilder，返回值为一个widget。
          // 当列表滚动到具体的index位置时，会调用该构建器构建列表项。
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text("Title $index"),
            );
          }),
    );
  }
}

class ListViewSeparatedRoute extends StatefulWidget {
  @override
  _ListViewSeparatedState createState() {
    return _ListViewSeparatedState();
  }
}

class _ListViewSeparatedState extends State<ListViewSeparatedRoute> {
  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(
      color: Colors.blue,
    );
    Widget divider2 = Divider(
      color: Colors.green,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView.separated"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text("Title $index"),
            );
          },
          // 分割组件生成器，偶数项是蓝色分割线，奇数行是绿色分割线。
          separatorBuilder: (BuildContext context, int index) {
            return index % 2 == 0 ? divider1 : divider2;
          },
          itemCount: 20),
    );
  }
}

class HorizontalListViewRoute extends StatefulWidget {
  @override
  _HorizontalListViewRouteState createState() =>
      _HorizontalListViewRouteState();
}

class _HorizontalListViewRouteState extends State<HorizontalListViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("横向的ListView"),
      ),
      body: ListView.builder(
          scrollDirection: Axis.horizontal,
          // 列表项的数量，如果为 null，则为无限列表
          itemCount: null,
          // 滚动方向上子组件的长度。在ListView中，指定itemExtent比让子组件自己决定自
          // 身长度会更高效，这是因为指定itemExtent后，滚动系统可以提前知道列表的长度，
          // 而无需每次构建子组件时都去再计算一下，尤其是在滚动位置频繁变化时（滚动系统需要频繁去计算列表高度）。
          itemExtent: 50,
          // shrinkWrap: true,
          // 列表项的构建器，类型是IndexedWidgetBuilder，返回值为一个widget。
          // 当列表滚动到具体的index位置时，会调用该构建器构建列表项。
          itemBuilder: (context, index) {
            // TODO 为什么这样写不显示啊？
            // return ListTile(
            //   leading: Text("Title $index"),
            // );
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              color: Colors.blue,
              child: Text(
                "Title $index",
                textAlign: TextAlign.center,
              ),
            );
          }),
    );
  }
}

class LoadMoreListViewRoute extends StatefulWidget {
  @override
  _LoadMoreListViewState createState() => _LoadMoreListViewState();
}

class _LoadMoreListViewState extends State<LoadMoreListViewRoute> {
  static const loadingTag = "##loading##"; // 表尾标记
  var _words = <String>[loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("实例：加载更多列表"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            if (_words[index] == loadingTag) {
              // 到了表尾
              if (_words.length - 1 < 100) {
                // 不足 100 条，继续获取数据
                _retrieveData();
                // 加载时显示 loading
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              } else {
                // 已经加载了 100 条数据，不再获取数据
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    "没有更多了",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                );
              }
            }
            // 显示单词列表项
            return ListTile(
              title: Text(_words[index]),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 0,
              ),
          itemCount: _words.length),
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}

class FixedHeaderListViewRoute extends StatefulWidget {
  @override
  _FixedHeaderListViewState createState() => _FixedHeaderListViewState();
}

class _FixedHeaderListViewState extends State<FixedHeaderListViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("实例：固定列表头的ListView"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: ListTile(leading: Text("新闻列表")),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          Divider(
            color: Colors.grey[200],
            height: 1.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("Title $index"),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey,
                  height: 1.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
