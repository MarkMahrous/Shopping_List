import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  void _removeItem(int index) {
    final item = _groceryItems[index];
    setState(() {
      _groceryItems.remove(_groceryItems[index]);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item removed!'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _groceryItems.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
      ),
      body: _groceryItems.isEmpty
          ? const Center(
              child: Text('No items added yet, start adding Some!'),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (ctx, index) {
                final item = _groceryItems[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  onDismissed: (direction) {
                    _removeItem(index);
                  },
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    leading: CircleAvatar(
                      backgroundColor: item.category.color,
                      child: Text(item.category.title[0]),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
