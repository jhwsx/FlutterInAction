import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter11_file_network/_11_1_file_operations.dart';

class FileNetworkRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第十一章：文件操作与网络请求'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return FileOperationsRoute();
              }));
            },
            child: Text('11.1 文件操作'),
          ),
        ],
      ),
    );
  }
}
