import 'package:flutter/material.dart';

class CompositeExistingWidgetRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10.2 组合现有组件"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return GradientButtonRoute();
              }));
            },
            child: Text('渐变色按钮'),
          ),
        ],
      ),
    );
  }
}

class GradientButtonRoute extends StatefulWidget {
  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {

  void _onTap() {
    setState(() {
      print('click');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('渐变色按钮'),
      ),
      body: Column(
        children: <Widget>[
          GradientButton(
            child: Text('登录'),
            colors: [Colors.orange, Colors.red],
            height: 50.0,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            onTap: _onTap,
          ),
          GradientButton(
            child: Text('注册'),
            colors: [Colors.green[400], Colors.green[700]],
            height: 50.0,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            onTap: _onTap,
          ),
        ],
      ),
    );
  }
}

// 渐变背景按钮
// 背景支持渐变色
// 手指按下时有涟漪效果
// 可以支持圆角
class GradientButton extends StatelessWidget {
  GradientButton(
      {this.colors,
      this.borderRadius,
      this.onTap,
      this.width,
      this.height,
      @required this.child});

  final List<Color> colors;

  final BorderRadius borderRadius;

  final GestureTapCallback onTap;

  final double width;
  final double height;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        // A transparent piece of material that draws ink splashes and highlights.
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onTap,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
