import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
// import 'package:flutter/rendering.dart';
//import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart'
    as http; // all content should be bundled into the name of 'http'

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  // var _isLoading = true;
  late Future<List<GroceryItem>>
      _loadedItems; // 'late' we have no initial values but we will have values before it is used the first time.
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'flutter-shop-2da1c-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      // New hotness:
      throw Exception('Failed to fetch');

      //old and busted
      // setState(() {
      //   _error = 'Failed to fetch data';
      // });
    }

    // for firebase make sure there are items in the list, or else it'll show loading forever!!!
    if (response.body == 'null') {
      //FutureBuilder will handle state
      // setState(() {
      //   _isLoading = false;
      // });
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;

      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }
    return loadedItems;
    // setState(() {
    //   _groceryItems = loadedItems;
    //   _isLoading = false;
    // });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https('flutter-shop-2da1c-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  void _addItem() async {
    final newItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    )); // push new screen

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });

    // *** Now crazy instructor guy thinks calling to save and calling to read with 2 calls it too much - I could have told you that
    //_loadItems();

    // item not returning from the pop fn, so we don't need this now.
    // if (newItem == null) {
    //   return;
    // }
    // setState(() {
    // setstate so that we run build method again so we get the new item to display
    //  _groceryItems.add(newItem);
    //}
    //);
  }

  @override
  Widget build(BuildContext context) {
    // Moving this message too because of course.
    // Widget content = const Center(
    //   child: Text('No items'),
    // );

    // This is now handled by the futurebuilder
    // if (_isLoading) {
    //   content = const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    // Moving more stuff because of course.
    // if (_groceryItems.isNotEmpty) {
    //   content = ListView.builder(
    //     itemCount: _groceryItems.length,
    //     itemBuilder: (ctx, index) => Dismissible(
    //       key: ValueKey(_groceryItems[index].id),
    //       background: Container(
    //         color: Colors.red,
    //         alignment: Alignment.centerRight,
    //         padding: const EdgeInsets.only(right: 20.0),
    //         child: const Icon(Icons.delete, color: Colors.white),
    //       ),
    //       onDismissed: (direction) {
    //         _removeItem(_groceryItems[index]);
    //       },
    //       child: ListTile(
    //         title: Text(_groceryItems[index].name),
    //         leading: Container(
    //           width: 24,
    //           height: 24,
    //           color: _groceryItems[index].category.color,
    //         ),
    //         trailing: Text(_groceryItems[index].quantity.toString()),
    //       ),
    //     ),
    //   );
    // }

    // Handling error message elsewhere of course!
    // if (_error != null) {
    //   content = Center(child: Text(_error!));
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        // Adding this is an exercise in example of Future builder - breaks a few things because state isn't being updated - but we shall move on.
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(snapshot.data![index].id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _removeItem(snapshot.data![index]);
              },
              child: ListTile(
                title: Text(snapshot.data![index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: snapshot.data![index].category.color,
                ),
                trailing: Text(snapshot.data![index].quantity.toString()),
              ),
            ),
          );
        },
      ),

      //content,
    );
  }
}
