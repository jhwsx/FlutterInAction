import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Item {
  Item(this.price, this.count);

  double price;

  int count;
}

class CartModel extends ChangeNotifier {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(
      0,
      (previousValue, element) =>
          previousValue + element.count * element.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class CartRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车列表"),
      ),
      body: ChangeNotifierProvider.value(
        value: CartModel(),
        child: TotalPricePage(),
      ),
    );
  }
}

class TotalPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartModel>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("总价：${_cart.totalPrice}"),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ChangeNotifierProvider.value(
                  value: _cart,
                  child: AddItemRoute(),
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

class AddItemRoute extends StatefulWidget {
  @override
  _AddItemRouteState createState() => _AddItemRouteState();
}

class _AddItemRouteState extends State<AddItemRoute> {
  @override
  Widget build(BuildContext context) {
    var _cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("添加商品页"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              _cart.add(Item(30.0, 1));
            },
            child: Text("添加商品"),
          ),
        ),
      ),
    );
  }
}
