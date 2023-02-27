import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/providers/cart.dart';
import 'package:flutter_shopping_app/providers/orders.dart';
import 'package:flutter_shopping_app/providers/products_provider.dart';
import 'package:flutter_shopping_app/screens/cart_screen.dart';
import 'package:flutter_shopping_app/screens/edit_product_screen.dart';
import 'package:flutter_shopping_app/screens/orders_screen.dart';
import 'package:flutter_shopping_app/screens/product_detail_screen.dart';
import 'package:flutter_shopping_app/screens/products_overview_screen.dart';
import 'package:flutter_shopping_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            primaryTextTheme:
                const TextTheme(headline1: TextStyle(color: Colors.white))),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routrName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          EditProductScreen.routeName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
