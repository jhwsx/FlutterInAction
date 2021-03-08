import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FixedCrossAxisCountGridViewRoute();
              }));
            },
            child: Text("相交轴上设置固定数量子元素的 GridView"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GridViewCountRoute();
              }));
            },
            child: Text("GridView.count"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MaxCrossExtentGridViewRoute();
              }));
            },
            child: Text("相交轴上设置子元素最大宽度的 GridView"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GridViewExtentRoute();
              }));
            },
            child: Text("GridView.extent"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GridViewBuilderRoute();
              }));
            },
            child: Text("GridView.builder"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return LoadMoreGridViewRoute();
              }));
            },
            child: Text("实例：加载更多 GridView"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return StaggeredGridViewRoute();
              }));
            },
            child: Text("StaggeredGridView"),
          ),
        ],
      ),
    );
  }
}

class FixedCrossAxisCountGridViewRoute extends StatefulWidget {
  @override
  _FixedCrossAxisCountGridViewRouteState createState() =>
      _FixedCrossAxisCountGridViewRouteState();
}

// SliverGridDelegate 是一个抽象类，定义了 GridView 的 layout 接口。
// SliverGridDelegateWithFixedCrossAxisCount 是其一个子类。
class _FixedCrossAxisCountGridViewRouteState
    extends State<FixedCrossAxisCountGridViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("相交轴上设置固定数量子元素的 GridView"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // 在相交轴上有 3 个 widget
            crossAxisCount: 3,
            // 子组件的宽高比
            childAspectRatio: 1.0,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.ac_unit),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.airport_shuttle),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.all_inclusive),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.beach_access),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.cake),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.free_breakfast),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// GridView.count构造函数内部使用了SliverGridDelegateWithFixedCrossAxisCount，
// 我们通过它可以快速的创建横轴固定数量子元素的GridView
class GridViewCountRoute extends StatefulWidget {
  @override
  _GridViewCountRouteState createState() => _GridViewCountRouteState();
}

class _GridViewCountRouteState extends State<GridViewCountRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView.count"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          8.0,
        ),
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.ac_unit),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.airport_shuttle),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.all_inclusive),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.beach_access),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.cake),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.free_breakfast),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaxCrossExtentGridViewRoute extends StatefulWidget {
  @override
  _MaxCrossExtentGridViewRouteState createState() =>
      _MaxCrossExtentGridViewRouteState();
}

class _MaxCrossExtentGridViewRouteState
    extends State<MaxCrossExtentGridViewRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("相交轴上设置子元素最大宽度的 GridView"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            // 子元素在相交轴上的最大长度，不一定是实际长度，
            // 如果子元素个数乘以这个最大长度，还小于相交轴的长度，那么最大长度就是实际长度了。
            // 如果子元素个数诚意这个最大长度，却大于相交轴的长度，那么实际长度就是相交轴长度除以子元素个数的均分值。
            maxCrossAxisExtent: 60,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 2.0,
          ),
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.ac_unit),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.airport_shuttle),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.all_inclusive),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.beach_access),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.cake),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.free_breakfast),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewExtentRoute extends StatefulWidget {
  @override
  _GridViewExtentRouteState createState() => _GridViewExtentRouteState();
}

class _GridViewExtentRouteState extends State<GridViewExtentRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView.extent"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          8.0,
        ),
        child: GridView.extent(
          maxCrossAxisExtent: 60.0,
          childAspectRatio: 2.0,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.ac_unit),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.airport_shuttle),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.all_inclusive),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.beach_access),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.cake),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: Icon(Icons.free_breakfast),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// GridView.builder 动态创建子 widget，使用子 widget 比较多的情况。
class GridViewBuilderRoute extends StatefulWidget {
  @override
  _GridViewBuilderRouteState createState() => _GridViewBuilderRouteState();
}

class _GridViewBuilderRouteState extends State<GridViewBuilderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView.builder"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          8.0,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 2.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.blue,
              child: Center(
                child: Text("$index"),
              ),
            );
          },
          itemCount: null,
        ),
      ),
    );
  }
}

class LoadMoreGridViewRoute extends StatefulWidget {
  @override
  _LoadMoreGridViewRouteState createState() => _LoadMoreGridViewRouteState();
}

class _LoadMoreGridViewRouteState extends State<LoadMoreGridViewRoute> {
  var _words = <String>[];

  @override
  void initState() {
    super.initState();
    _retrieveData(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "实例：加载更多 GridView",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          8.0,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (index == _words.length - 1 && _words.length < 100) {
              _retrieveData(2);
            }
            return Container(
              alignment: Alignment.center,
              child: Text(
                _words[index],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            );
          },
          itemCount: _words.length,
        ),
      ),
    );
  }

  void _retrieveData(int delay) {
    Future.delayed(Duration(seconds: delay)).then((value) {
      setState(() {
        if (_words.length == 0) {
          _words.addAll(
              generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
        } else {
          _words.insertAll(_words.length - 1,
              generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
        }
      });
    });
  }
}

class StaggeredGridViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "StaggeredGridView",
        ),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: null,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('$index'),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.count(2, index.isEven ? 2 : 1);
        },
      ),
    );
  }
}
