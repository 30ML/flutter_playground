import 'package:flutter/material.dart';
import 'package:flutter_ui_shopping_cart/components/shoppingcart_header.dart';
import 'package:flutter_ui_shopping_cart/components/shoppingcart_detail.dart';
import 'package:flutter_ui_shopping_cart/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildShoppingCartAppBar(),
      body: Column(
        children: [
          ShoppingCartHeader(),
          ShoppingCartDetail(),
        ],
      ),
    );
  }
}

AppBar _buildShoppingCartAppBar() {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {},
      ),
      SizedBox(width: 16),
    ],
    elevation: 0.0,
  );
}
