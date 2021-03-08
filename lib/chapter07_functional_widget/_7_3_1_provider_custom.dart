import 'dart:collection';

import 'package:flutter/material.dart';

/// 用于保存共享数据的 InheritedWidget。
class InheritedProvider<T> extends InheritedWidget {
  // 共享数据
  final T data;

  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

/// 商品信息类
class Item {
  Item(this.price, this.count);

  // 商品的单价
  double price;

  // 商品的数目
  int count;
}

/// 一个保存购物车内商品数据的 CartModel 类，即要跨组件共享的 model 类。
class CartModel extends ChangeNotifier {
  // 购物车里的商品列表
  final List<Item> _items = [];

  // 外部只可以获取购物车里的商品列表，而不可以改变它
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 获取购物车里的商品总价
  double get totalPrice => _items.fold(
      0,
          (previousValue, element) =>
      previousValue + element.count * element.price);

  // 将商品添加到购物车列表。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建 InheritedProvider，更新状态。
    print('CartModel: notifyListeners() called');
    notifyListeners();
  }
}

/// 订阅者类
/// 当共享的状态改变时，只需要调用 notifyListeners() 来通知订阅者，然后订阅者会重新
/// 构建 InheritedProvider。
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  ChangeNotifierProvider({Key key, this.child, this.data});

  final Widget child;
  final T data;

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();

  // 静态方法，子类用以获取 Widget 树中的 InheritedProvider 中保存的共享状态（model）
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
        .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
        ?.widget as InheritedProvider<T>;
    return provider.data;
  }
}

/// 作用：监听到共享状态（model）改变时重新构建 Widget 树。
class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {
      print('_ChangeNotifierProviderState: setState()');
    });
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    // 当 Provider 更新时，如果新旧数据不 “==”，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      print(
          '_ChangeNotifierProviderState: didUpdateWidget(), 解绑旧数据监听，同时添加新数据监听');
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给 model 添加监听器
    print('_ChangeNotifierProviderState: initState(), 给 model 添加监听器');
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除 model 的监听器
    print('_ChangeNotifierProviderState: dispose(), 移除 model 的监听器');
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class CartRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车列表"),
      ),
      body: Center(
        child: ChangeNotifierProvider(
          data: CartModel(),
          child: TotalPricePage(),
        ),
      ),
    );
  }
}

class TotalPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = ChangeNotifierProvider.of<CartModel>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 依赖 Model 的 Widget。
          Consumer<CartModel>(
              builder: (context, cart) => Text("总价：${cart.totalPrice}")),
          // Builder(builder: (context) {
          //   return Text("总价：${cart.totalPrice}");
          // }),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider(
                  child: AddItemRoute(),
                  data: cart,
                );
              }));
            },
            child: Text("去添加商品页"),
          ),
        ],
      ),
    );
  }
}

class Consumer<T> extends StatelessWidget {
  Consumer({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);

  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChangeNotifierProvider.of<T>(context));
  }
}

class AddItemRoute extends StatefulWidget {
  @override
  _AddItemRouteState createState() => _AddItemRouteState();
}

class _AddItemRouteState extends State<AddItemRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加商品页"),
      ),
      body: Container(
        child: Center(
          child: Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                ChangeNotifierProvider.of<CartModel>(context)
                    .add(Item(20.0, 1));
              },
              child: Text("添加商品"),
            );
          }),
        ),
      ),
    );
  }
}
