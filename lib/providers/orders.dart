import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/providers/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.amount,
    required this.products,
    required this.dateTime,
    required this.id,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
        id: DateTime.now().toString(),
      ),
    );
  }
}
