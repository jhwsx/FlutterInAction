import 'package:flutter/material.dart';
import 'package:flutter_in_action/chapter05_container_widget/_5_5_container.dart';

class AnimationStructureRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('9.2 动画基本结构及状态监听'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ScaleAnimationRoute();
              }));
            },
            child: Text("图片放大效果-基础版本"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ScaleAnimationRoute2();
              }));
            },
            child: Text("图片放大效果-使用 AnimatedWidget 简化"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ScaleAnimationRoute3();
              }));
            },
            child: Text("图片放大效果-用 AnimatedBuilder 重构"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ScaleAnimationRoute4();
              }));
            },
            child: Text("图片放大效果-用 AnimatedBuilder 复用动画"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return RepeatAnimationRoute();
              }));
            },
            child: Text("循环动画-使用动画监听"),
          ),
        ],
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

// 需要继承 TickerProvider，如果有多个 AnimationController, 则应该使用 TickerProviderStateMixin
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  // 负责插值，状态，生成值
  Animation<double> animation;

  // 动画控制器，继承自 Animation<double>，有动画的开始 forward, stop, reverse 等方法
  AnimationController controller;

  @override
  void initState() {
    // vsync 参数：用于接收一个 TickerProvider 类型的对象，主要是为了创建一个 Ticker。
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    // 添加插值器，这里是装饰器模式，把默认的线性插值变为了弹簧效果。
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 图片的宽高从 0 变到 300
    // Tween 派生自 Animatable<T>，用于指定区间。
    // 调用 animate 后，就把区间应用到指定的动画上了。
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      // 添加帧监听器，在这里获取每一帧。帧监听器中最常见的行为是改变状态后调用setState()来触发UI重建。
      ..addListener(() {
        // TODO 为什么这里只打印了两次？
        print('帧监听器被调用了');
        // 这句代码不写不行。
        setState(() {});
      })
      // 添加状态监听器，开始，停止，正向，反向
      ..addStatusListener((status) {
        ///// The status of an animation.
        // enum AnimationStatus {
        //   /// The animation is stopped at the beginning.
        //   dismissed,
        //
        //   /// The animation is running from beginning to end.
        //   forward,
        //
        //   /// The animation is running backwards, from end to beginning.
        //   reverse,
        //
        //   /// The animation is stopped at the end.
        //   completed,
        // }
        switch (status) {
          case AnimationStatus.dismissed:
            print('dismissed');
            break;
          case AnimationStatus.forward:
            print('forward');
            break;
          case AnimationStatus.reverse:
            print('reverse');
            break;
          case AnimationStatus.completed:
            print('completed');
            break;
          default:
            break;
        }
      });
    // 开始动画，正向执行
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // 释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片放大效果-基础版本"),
      ),
      body: Center(
        child: Image.asset(
          "./images/wzc_avatar.webp",
          width: animation.value,
          height: animation.value,
        ),
      ),
    );
  }
}

/// 省去了 addListener 和 setState 的代码
/// AnimatedWidget 类封装了调用 setState() 的细节
class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  _ScaleAnimationRoute2Route createState() => _ScaleAnimationRoute2Route();
}

class _ScaleAnimationRoute2Route extends State<ScaleAnimationRoute2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // 释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片放大效果-使用 AnimatedWidget 简化'),
      ),
      body: AnimatedImage(animation: animation),
    );
  }
}

class AnimatedImage extends AnimatedWidget {
  AnimatedImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // TODO 这里为什么要再赋值一下呢？
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        "./images/wzc_avatar.webp",
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

/// 抽象出来渲染过程，把 widget 和渲染过程分离开来。
/// AnimatedBuilder 缩小了 setState 的范围。
class ScaleAnimationRoute3 extends StatefulWidget {
  @override
  _ScaleAnimationRoute3State createState() {
    return _ScaleAnimationRoute3State();
  }
}

class _ScaleAnimationRoute3State extends State<ScaleAnimationRoute3>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片放大效果-用 AnimatedBuilder 重构'),
      ),
      // AnimatedBuilder 派生自 AnimatedWidget
      body: AnimatedBuilder(
          animation: animation,
          child: Image.asset("./images/wzc_avatar.webp"),
          // typedef TransitionBuilder = Widget Function(BuildContext context, Widget child);
          // 这个 kid 传入的值就是上面 child 的值。
          builder: (BuildContext context, Widget kid) {
            return Center(
              child: Container(
                height: animation.value,
                width: animation.value,
                child: kid,
              ),
            );
          }),
    );
  }
}

class ScaleAnimationRoute4 extends StatefulWidget {
  @override
  _ScaleAnimationRoute4State createState() => _ScaleAnimationRoute4State();
}

class _ScaleAnimationRoute4State extends State<ScaleAnimationRoute4>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片放大效果-用 AnimatedBuilder 复用动画'),
      ),
      body: GrowTransition(
        child: Image.asset('./images/wzc_avatar.webp'),
        animation: animation,
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key key, this.child, this.animation}) : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        child: child,
        animation: animation,
        // typedef TransitionBuilder = Widget Function(BuildContext context, Widget child);
        builder: (BuildContext context, Widget child) {
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}

class RepeatAnimationRoute extends StatefulWidget {
  @override
  _RepeatAnimationRouteState createState() {
    return _RepeatAnimationRouteState();
  }
}

class _RepeatAnimationRouteState extends State<RepeatAnimationRoute>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 动画恢复到初始状态时正向执行动画
        controller.forward();
      }
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('循环动画-使用动画监听'),
      ),
      body: GrowTransition(
        child: Image.asset('./images/wzc_avatar.webp'),
        animation: animation,
      ),
    );
  }
}
