import 'package:flutter/material.dart';
// 学习 Container 组件
// Container是一个组合类容器，它本身不对应具体的 RenderObject，它是 DecoratedBox、ConstrainedBox、
// Transform、Padding、Align等组件组合的一个多功能容器，所以我们只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景。
// 1,容器的大小可以通过width、height属性来指定，也可以通过constraints来指定；如果它们同时存在时，
// width、height优先。实际上Container内部会根据width、height来生成一个constraints。
// 2,color和decoration是互斥的，如果同时设置它们则会报错！实际上，当指定color时，Container内会自动创建一个decoration。
class ContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Container(容器)'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "卡片效果：",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 60.0),
                constraints: BoxConstraints.tightFor(width: 200, height: 150),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topLeft,
                    colors: [Colors.red, Colors.orange],
                    radius: 0.98,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                    )
                  ],
                ),
                transform: Matrix4.rotationZ(.2),
                alignment: Alignment.center,
                child: Text(
                  "5.20",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Padding和Margin：",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                color: Colors.orange,
                child: Text(
                  "Hello World!",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.orange,
                child: Text(
                  "Hello World!",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
