import 'package:flutter/material.dart';

class ScaffoldTabBarBottomNaviRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scaffold、TabBar、底部导航",
        ),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScaffoldRoute();
              }));
            },
            child: Text("Scaffold"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return BottomAppBarRoute();
              }));
            },
            child: Text("BottomAppBar"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomAppBarRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BottomAppBar"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home), onPressed: (){},),
            SizedBox(),
            IconButton(icon: Icon(Icons.person), onPressed: (){},),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() {
    return _ScaffoldRouteState();
  }
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  TabController _tabController;

  @override
  void initState() {
    // 用于控制/监听Tab菜单切换的
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Name"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          tabs: <Tab>[
            Tab(
              text: "新闻",
              icon: Icon(
                Icons.person,
              ),
            ),
            Tab(
              text: "历史",
              icon: Icon(
                Icons.history,
              ),
            ),
            Tab(
              text: "图片",
              icon: Icon(
                Icons.image,
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
      drawer: MyDrawer(),
      endDrawer: MyEndDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: "Business",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "School",
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: TabBarView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "新闻",
              textScaleFactor: 3,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "历史",
              textScaleFactor: 3,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "图片",
              textScaleFactor: 3,
            ),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding. 移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Flutter in action",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text("Add account"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyEndDrawer extends StatelessWidget {
  const MyEndDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding. 移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Kotlin in action",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text("Add account"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
