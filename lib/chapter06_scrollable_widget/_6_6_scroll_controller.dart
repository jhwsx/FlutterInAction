import 'package:flutter/material.dart';

class ScrollRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("6.6 滚动监听及控制"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScrollControllerRoute();
              }));
            },
            child: Text('ScrollController'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PageStorageRoute();
              }));
            },
            child: Text('PageStorage-恢复滚动位置'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScrollNotificationRoute();
              }));
            },
            child: Text('ScrollNotification'),
          ),
        ],
      ),
    );
  }
}

class ScrollControllerRoute extends StatefulWidget {
  @override
  _ScrollControllerRouteState createState() {
    return _ScrollControllerRouteState();
  }
}

class _ScrollControllerRouteState extends State<ScrollControllerRoute> {
  ScrollController _controller = ScrollController();
  var _showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print('滚动位置：${_controller.offset}');
      if (_controller.offset < 1000 && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !_showToTopBtn) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ScrollController',
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          key: PageStorageKey<String>("key"),
          controller: _controller,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index"),
            );
          },
          itemCount: 100,
          itemExtent: 50.0,
        ),
      ),
      floatingActionButton: _showToTopBtn
          ? FloatingActionButton(
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(milliseconds: 200), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}

// 这个例子来自 page_storage.dart.
class PageStorageRoute extends StatefulWidget {
  @override
  _PageStorageRouteState createState() => _PageStorageRouteState();
}

class _PageStorageRouteState extends State<PageStorageRoute> {
  final List<Widget> pages = <Widget>[
    ColorBoxPage(
      key: PageStorageKey("pageOne"),
    ),
    ColorBoxPage(
      key: PageStorageKey("pageTwo"),
    ),
  ];
  int currentTab = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PageStorage-恢复滚动位置")),
      // PageStorage 是一个用于保存页面相关数据的组件，它不会影响子树的 UI，是一个功能型组件。
      body: PageStorage(
        // 存储桶
        bucket: _bucket,
        child: pages[currentTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "page 1",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "page 2",
          ),
        ],
      ),
    );
  }
}

class ColorBoxPage extends StatelessWidget {
  ColorBoxPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(
          10.0,
        ),
        child: Material(
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class ScrollNotificationRoute extends StatefulWidget {
  @override
  _ScrollNotificationRouteState createState() =>
      _ScrollNotificationRouteState();
}

class _ScrollNotificationRouteState extends State<ScrollNotificationRoute> {
  String _progress = "0%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ScrollNotification',
        ),
      ),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                itemExtent: 50.0,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                  );
                },
              ),
              CircleAvatar(
                radius: 30.0,
                child: Text(_progress),
                backgroundColor: Colors.black45,
              ),
            ],
          ),
          onNotification: (notification) {
            // 进度的小数 = 当前滚动位置 / 最大可滚动长度
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress = "${(progress * 100).toInt()}%";
            });
            print('BottomEdge: ${notification.metrics.extentAfter == 0}');
            print('TopEdge: ${notification.metrics.extentBefore == 0}');
            // return true; // 放开这行，进度条就会失效。
          },
        ),
      ),
    );
  }
}
