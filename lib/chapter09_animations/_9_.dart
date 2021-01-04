import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter09_animations/_9_2_animation_structure.dart';
import 'package:flutter_in_action/chapter09_animations/_9_3_custom_route_animation.dart';

class AnimationsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第九章：动画'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AnimationStructureRoute();
              }));
            },
            child: Text("9.2 动画基本结构及状态监听"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CustomRouteAnimationRoute();
              }));
            },
            child: Text("9.3 自定义路由切换动画"),
          ),
        ],
      ),
    );
  }
}
