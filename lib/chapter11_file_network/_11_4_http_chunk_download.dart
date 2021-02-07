import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpChunkDownloadRoute extends StatefulWidget {
  @override
  _HttpChunkDownloadRouteState createState() => _HttpChunkDownloadRouteState();
}

class _HttpChunkDownloadRouteState extends State<HttpChunkDownloadRoute> {

  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11.4 实例：Http分块下载'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }

  Future downloadWithChunks(String url, String savePath, ProgressCallback onReceiveProgress) async {
    const int firstChunkSize = 102;
    const int maxChunk = 3;
    int total = 0;
    List<int> progress = <int>[];

    createCallback(no) {
      
    }
  }
  Future<Response> downloadChunk(url, start, end, no) async {

  }
}
