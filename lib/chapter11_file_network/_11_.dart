import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter11_file_network/_11_1_file_operations.dart';
import 'package:flutter_in_action/chapter11_file_network/_11_2_httpclient.dart';
import 'package:flutter_in_action/chapter11_file_network/_11_3_dio.dart';
import 'package:flutter_in_action/chapter11_file_network/_11_4_http_chunk_download.dart';
import 'package:flutter_in_action/chapter11_file_network/json_parse.dart';

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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return HttpClientRoute();
              }));
            },
            child: Text('11.2 通过HttpClient发起HTTP请求'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return DioRoute();
              }));
            },
            child: Text('11.3 Http请求-Dio http库'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return HttpChunkDownloadRoute();
              }));
            },
            child: Text('11.4 实例：Http分块下载'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return JsonParseWidget();
              }));
            },
            child: Text('Json 渐进式解析'),
          ),
        ],
      ),
    );
  }
}
