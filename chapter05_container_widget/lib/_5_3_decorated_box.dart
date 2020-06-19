import 'package:flutter/material.dart';

// 学习 DecoratedBox
// 1, DecoratedBox 可以在其子组件绘制前（或后）绘制一些装饰，如背景，边框，渐变等。
// 2, 属性：final Decoration decoration; 表示要绘制的装饰， Decoration 是一个抽象类，
// 通常使用 BoxDecoration, 它继承于 Decoration， 是一个具体类。
// 3, 属性： final DecorationPosition position; 决定是在子组件的后面绘制还是子组件
// 之上绘制装饰，DecorationPosition 是一个枚举类，有两个值：background 和 foreground。
// background：表示在子组件的后面绘制装饰，即作为子组件的背景装饰
// foreground：表示在子组件的上面绘制装饰，即作为子组件的前景装饰
// 4, 再看一下 BoxDecoration 有哪些属性：
//   const BoxDecoration({
//    this.color,
//    this.image,
//    this.border,
//    this.borderRadius,
//    this.boxShadow,
//    this.gradient,
//    this.backgroundBlendMode,
//    this.shape = BoxShape.rectangle,
//  })
// final Color color：填充 box 背景的颜色，如果 gradient 不为 null，这个值被忽略，
// color 是在 image 的下面绘制的。
// final DecorationImage image：绘制在背景的 color 或 gradient 上面的图片
// final BoxBorder border: 在 color，gradient，image 的上面绘制的 border
class DecoratedBoxRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('装饰容器 DecoratedBox')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.red, Colors.orange[700]]),
              borderRadius: BorderRadius.circular(3.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: const Alignment(-0.5, -0.6),
                  radius: 0.15,
                  colors: <Color>[
                    const Color(0xFFEEEEEE),
                    const Color(0xFF111133),
                  ],
                  stops: <double>[
                    0.9,
                    1.0
                  ]),
            ),
            child: SizedBox(
              width: 200,
              height: 100,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: Colors.black,
                width: 8,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(5.0, 5.0),
                    blurRadius: 5.0),
              ],
            ),
            child: SizedBox(
              width: 200,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
