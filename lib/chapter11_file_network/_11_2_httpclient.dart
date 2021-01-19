import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpClientRoute extends StatefulWidget {
  @override
  _HttpClientRouteState createState() => _HttpClientRouteState();
}

class _HttpClientRouteState extends State<HttpClientRoute> {
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('11.2 通过HttpClient发起HTTP请求'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _text = "正在请求...";
                        });
                        try {
                          // 创建一个 HttpClient 对象
                          HttpClient httpClient = HttpClient();
                          // 对应请求头中的 keep-alive 字段值
                          httpClient.idleTimeout = Duration(seconds: 30);
                          // 设置连接超时
                          httpClient.connectionTimeout = Duration(seconds: 15);
                          // 同一个 host，同时允许建立连接的最大数量
                          httpClient.maxConnectionsPerHost = 2;
                          // 用于添加用户凭据的方法
                          // httpClient.addCredentials(url, realm, credentials)
                          // 打开 Http 连接
                          HttpClientRequest request = await httpClient
                              .getUrl(Uri.parse("https://www.baidu.com"));
                          request.headers.add("user-agent",
                              "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                          // 等待连接服务器（将请求信息发送给服务器）
                          HttpClientResponse response = await request.close();
                          // 读取响应内容，设置 utf8 解码
                          _text = await response.transform(utf8.decoder).join();
                          // 输出响应头
                          print(response.headers);

                          // 关闭 client，则通过这个 client 发起的所有请求都会终止。
                          httpClient.close();
                        } catch (e) {
                          _text = "请求失败：$e";
                        } finally {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
                child: Text('获取百度首页'),
              ),
              Container(
                // MediaQuery.of(context).size.width 获取到屏幕的宽度
                width: MediaQuery.of(context).size.width - 50.0,
                // 使用正则表达式去掉所有的空白符
                child: Text(_text.replaceAll(RegExp(r'\s'), '')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
