import 'package:flutter/material.dart';

import '_7_3_1_provider_custom.dart';
import '_7_3_2_provider_pub.dart';

class ProviderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("7.3 跨组件状态共享（Provider）"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            child: Text("购物车实例（使用自定义的 Provider）"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CartRoute();
              }));
            },
          ),
          ElevatedButton(
            child: Text("购物车实例（使用 pub 的 Provider）"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return CartRoute2();
              }));
            },
          ),
        ],
      ),
    );
  }
}
