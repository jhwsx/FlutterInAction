import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter09_animations/_9_2_animation_structure.dart';

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
        ],
      ),
    );
  }
}
