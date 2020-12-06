import 'package:flutter/material.dart';

class CustomScrollViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          // 导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('CustomScrollView'),
              background: Image.asset(
                "./images/wzc_avatar.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 网格列表
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
            ),
          ),
          // 列表
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * index % 9],
                  child: Text('list item $index'),
                );
              },
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
