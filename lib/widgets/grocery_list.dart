import 'package:flutter/material.dart';

import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Groceries'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const NewItem()),
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (ctx, index) {
            final item = groceryItems[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('Quantity: ${item.quantity}'),
              leading: CircleAvatar(
                backgroundColor: item.category.color,
                child: Text(item.category.title[0]),
              ),
            );
          },
        ));
  }
}
