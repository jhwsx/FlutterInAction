import 'package:flutter/material.dart';

// 知识点:
// 图片加载
// 字体图标: 使用Material Design字体图标；使用自定义字体图标
// Flutter 中通过 Image 组件来加载并显示图片, Image 的数据源可以是 assets, 文件, 内存以及网络.
class ImageIconRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片及Icon'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image(
              // 不指定宽高,图片会根据当前父容器的限制,尽量显示原始图片大小.
              image: AssetImage('images/avatar.webp'),
            ),
            Image(
              // 指定了宽度,另一个属性默认是按比例缩放
              image: AssetImage("images/avatar.webp"),
              width: 100,
            ),
            Image(
              // 指定了高度,另一个属性默认是按比例缩放
              image: AssetImage('images/avatar.webp'),
              height: 50,
            ),
            Image(
              image: AssetImage('images/avatar.webp'),
              height: 50,
              width: 100,
            ),
            Image.asset(
              "images/avatar.webp",
              width: 100,
            ),
            Image(
              image: NetworkImage(
                "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              ),
              width: 100,
            ),
            Image.network(
              'https://avatars2.githubusercontent.com/u/20411648?s=460&v=4',
              width: 100,
            ),
            Image(
              image: AssetImage('images/avatar.webp'),
              width: 100,
              height: 100,
              color: Colors.red[100],
              colorBlendMode: BlendMode.lighten,
            ),
            Image(
              image: AssetImage('images/avatar.webp'),
              width: 100,
              color: Colors.blue,
              colorBlendMode: BlendMode.difference,
            ),
            Image(
              image: AssetImage('images/avatar.webp'),
              width: 100,
              height: 200,
              repeat: ImageRepeat.repeatY,
            ),
            // 使用Material Design字体图标
            Text("\uE914 \uE000 \uE90D",
                style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 48,
                  color: Colors.blue,
                )),
            Row(
              children: [
                Icon(
                  Icons.accessibility,
                  color: Colors.green,
                  size: 48,
                ),
                Icon(
                  Icons.error,
                  color: Colors.green,
                  size: 48,
                ),
                Icon(
                  Icons.fingerprint,
                  color: Colors.green,
                  size: 48,
                ),
              ],
            ),
            // 自定义字体图标
            // https://juejin.im/post/5d2994b86fb9a07eac06024a
            Row(
              children: [
                Icon(
                  MyIconFamily.accessibility,
                  color: Colors.grey,
                  size: 48,
                ),
                Icon(
                  MyIconFamily.fire,
                  color: Colors.red,
                  size: 48,
                ),
                Icon(
                  MyIconFamily.phone,
                  color: Colors.blue,
                  size: 48,
                ),
              ],
            ),
            Column(
              children: [
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.fill, // 通过改变原图的宽高比来填充目标容器
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.fill, // 通过改变原图的宽高比来填充目标容器
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.contain,
                  // As large as possible while still containing the source entirely within the
                  // target box.这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.contain, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.cover,
                  // As small as possible while still covering the entire target box.
                  // 会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.cover, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.fitWidth,
                  // Make sure the full width of the source is shown, regardless of
                  // whether this means the source overflows the target box vertically.
                  // 图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.fitWidth, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitWidth, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.fitHeight,
                  // Make sure the full height of the source is shown, regardless of
                  // whether this means the source overflows the target box horizontally.
                  // 图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.fitHeight, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.none,
                  // Align the source within the target box (by default, centering) and discard
                  // any portions of the source that lie outside the box.
                  // The source image is not resized.
                  // 图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.none, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.none, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 50,
                  fit: BoxFit.scaleDown,
                  // Align the source within the target box (by default, centering) and, if
                  // necessary, scale the source down to ensure that the source fits within the
                  // box.
                  //
                  // This is the same as `contain` if that would shrink the image, otherwise it
                  // is the same as `none`.
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 50,
                  height: 100,
                  fit: BoxFit.scaleDown, //
                ),
                Image(
                  image: AssetImage('images/avatar.webp'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.scaleDown, //
                ),
              ].map((e) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          child: e,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(e.fit.toString())
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ].map((e) {
            return Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                e,
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MyIconFamily {
  static const IconData accessibility = const IconData(
    0xe7b4,
    fontFamily: 'myIconFamily',
    matchTextDirection: true,
  );
  static const IconData phone = const IconData(
    0xe661,
    fontFamily: 'myIconFamily',
    matchTextDirection: true,
  );
  static const IconData fire = const IconData(
    0xe721,
    fontFamily: 'myIconFamily',
    matchTextDirection: true,
  );
}
