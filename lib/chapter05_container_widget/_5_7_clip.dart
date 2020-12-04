import 'package:flutter/material.dart';

class ClipRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/wzc_avatar.webp", width: 60);
    return Scaffold(
      appBar: AppBar(
        title: Text("剪裁（Clip）"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "原图: ",
            ),
            avatar,
            Text(
              "裁剪为圆形: ",
            ),
            ClipOval(
              child: avatar,
            ),
            ClipOval(
              child: Image.asset(
                "images/book.webp",
                width: 60,
              ),
            ),
            Text(
              "裁剪为圆角矩形: ",
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: avatar,
            ),
            Text(
              "不使用 ClipRect 溢出部分仍然会显示：",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: avatar,
                ),
                Text(
                  "willwaywang6",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            // 使用了 ClipRect 包裹 Align，解决了图片溢出部分显示的问题。
            Text(
              "使用 ClipRect 溢出部分不再会显示：",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.5,
                    child: avatar,
                  ),
                ),
                Text(
                  "willwaywang6",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Text(
              "裁剪左边从 10.0 开始，顶部从 15.0 开始，宽x高为 40x30 的区域：",
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: ClipRect(
                child: avatar,
                clipper: MyCustomClipper(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Rect> {
  // 获取裁剪区域
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);
  }

  // 接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回false，这样就不会触发重新剪裁，
  // 避免不必要的性能开销。如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），那么变化后应该返回true来重新执行剪裁。
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
