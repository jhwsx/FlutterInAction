import 'package:flutter/material.dart';

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('9.4 Hero动画'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        // InkWell 是一个响应触摸的矩形区域
        child: InkWell(
          child: Hero(
            tag: "avatar",
            child: ClipOval(
              child: Image.asset(
                "./images/wzc_avatar.webp",
                width: 50.0,
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(pageBuilder:
                (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
              return HeroAnimationRouteB();
            }, transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }));
          },
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('原图'),
      ),
      body: Center(
        child:
            Hero(tag: "avatar", child: Image.asset("./images/wzc_avatar.webp")),
      ),
    );
  }
}
