import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter06_scrollable_widget/_6_5_custom_scrollview.dart';
import 'package:flutter_in_action/chapter06_scrollable_widget/_6_6_scroll_controller.dart';
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SingleChildScrollViewRoute();
              }));
            },
            child: Text('6.2 SingleChildScrollView'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ListViewRoute();
              }));
            },
            child: Text('6.3 ListView'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GridViewRoute();
              }));
            },
            child: Text('6.4 GridView'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CustomScrollViewRoute();
              }));
            },
            child: Text('6.5 CustomScrollView'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScrollRoute();
              }));
            },
            child: Text('6.6 滚动监听及控制'),
          ),
        ],
      ),
    );
  }
}
