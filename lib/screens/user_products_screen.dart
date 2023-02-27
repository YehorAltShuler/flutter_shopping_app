import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/screens/edit_product_screen.dart';
import 'package:flutter_shopping_app/widgets/app_drawer.dart';
import 'package:flutter_shopping_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                  title: productsData.items[i].title,
                  imageUrl: productsData.items[i].imageUrl),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
