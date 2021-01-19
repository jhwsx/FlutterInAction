import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioRoute extends StatefulWidget {
  @override
  _DioRouteState createState() => _DioRouteState();
}

class _DioRouteState extends State<DioRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11.3 Http请求-Dio http库'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future:
                  _dio.get("https://api.github.com/orgs/flutterchina/repos"),
              // typedef AsyncWidgetBuilder<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // 根据状态，决定显示什么状态
                if (snapshot.connectionState == ConnectionState.done) {
                  Response response = snapshot.data;
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return ListView(
                    children: response.data
                        .map<Widget>((e) => ListTile(
                              title: Text(e['full_name']),
                            ))
                        .toList(),
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
