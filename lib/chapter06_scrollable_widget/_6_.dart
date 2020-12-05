import 'package:flutter/material.dart';
import '_6_3_list_view.dart';
import '_6_2_single_child_scrollview.dart';
import '_6_4_grid_view.dart';

class Chapter06ScrollableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第六章：可滚动组件"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SingleChildScrollViewRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('6.2 SingleChildScrollView'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListViewRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('6.3 ListView'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GridViewRoute();
              }));
            },
            colorBrightness: Brightness.dark,
            color: Colors.blue,
            child: Text('6.4 GridView'),
          ),
        ],
      ),
    );
  }
}
