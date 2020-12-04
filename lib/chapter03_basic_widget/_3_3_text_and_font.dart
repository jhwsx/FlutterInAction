// Text 属性
// TextStyle style, 样式
// strutStyle,

// TextAlign textAlign, 文本的对齐方式；可以选择左对齐、右对齐还是居中。注意，对齐的参考系是
// Text widget本身。本例中虽然是指定了居中对齐，但因为Text文本内容宽度不足一行，Text的宽度和
// 文本内容长度相等，那么这时指定对齐方式是没有意义的，只有Text宽度大于文本内容长度时指定此属性才有意义。

// textDirection,
// locale,
// softWrap,
// TextOverflow overflow, 指定截断方式, 默认是直接截断的(clip). clip, ellipsis, fade, visible
// textScaleFactor, 想对于当前字体大小 (fontSize 指定的)的缩放因子
// int maxLines, 最大行数
// semanticsLabel,
// textWidthBasis,
// textHeightBehavior,
import 'package:flutter/material.dart';

class TextFontRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('文本字体样式')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello world!',
            textAlign: TextAlign.left,
          ),
          Text(
            "Hello world! I'm wangzhichao" * 4,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Hello world!',
            textScaleFactor: 1.5,
          ),
          Text(
            "Hello world! I'm wangzhichao" * 6,
            textAlign: TextAlign.center,
          ),
          Text(
            "Hello world! I'm wangzhichao" * 10,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.visible,
          ),
          Text(
            "Hello world! I'm wangzhichao",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Hello world! I'm wangzhichao",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            "Hello world! I'm wangzhichao",
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
          Text(
            "Hello world! I'm wangzhichao",
            style: TextStyle(
                height: 2.0), // height 是一个因子，具体的行高等于 fontSize * height。
          ),
          Text("Hello world! I'm wangzhichao",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
              )),
          Text("Hello world! I'm wangzhichao",
              style: TextStyle(
                background: Paint()..color = Colors.yellow,
              )),
          Text("Hello world! I'm wangzhichao",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.dashed,
                decorationThickness: 1.5,
              )),
          Text.rich(TextSpan(
            children: [
              TextSpan(text: 'Hello world! '),
              TextSpan(
                  text: "I'm wangzhichao", style: TextStyle(color: Colors.blue))
            ],
          )),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "赤",
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: "橙",
                  style: TextStyle(color: Colors.orange),
                ),
                TextSpan(
                  text: "绿",
                  style: TextStyle(color: Colors.green),
                ),
                TextSpan(
                  text: "蓝",
                  style: TextStyle(color: Colors.blue),
                ),
                TextSpan(
                  text: "靛",
                  style: TextStyle(color: Colors.cyan),
                ),
                TextSpan(
                  text: "紫",
                  style: TextStyle(color: Colors.purple),
                ),
              ],
            ),
          ),
          DefaultTextStyle(
            // DefaultTextStyle 设置默认文本样式, 所有位于该节点的子(包括孙...)树中所有默认使用这个样式
            style: TextStyle(color: Colors.red, fontSize: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello world!'),
                Text("I'm wangzhichao"),
                Text(
                  'I love China',
                  style: TextStyle(
                    inherit: false, // 不继承默认样式
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    // 孙节点
                    Text('Hello, world!'),
                  ],
                ),
              ],
            ),
          ),
          Text(
            'use font: I love China',
            style: const TextStyle(fontFamily: 'Goldman'),
          ),
          Text(
            "I love you",
            style: const TextStyle(
              fontFamily: "StalinistOne",
              package: "chapter03_basic_widget",
            ),
          ),
        ],
      ),
    );
  }
}
