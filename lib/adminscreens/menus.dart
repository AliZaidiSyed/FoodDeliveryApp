import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageMenus extends StatefulWidget {
  const ManageMenus({super.key, required String restaurantId, required String restaurantName});

  @override
  State<ManageMenus> createState() => _ManageMenusState();
}

class _ManageMenusState extends State<ManageMenus> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedRestaurantId;

  void _addMenuItem() {
    if (_selectedRestaurantId != null) {
      final String itemName = _itemController.text.trim();
      final int? price = int.tryParse(_priceController.text.trim());

      if (itemName.isEmpty || price == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter valid item and price')),
        );
        return;
      }

      FirebaseFirestore.instance
          .collection('resturants')
          .doc(_selectedRestaurantId)
          .collection('menus')
          .add({
        'item': itemName,
        'price': price, 
      });
      _itemController.clear();
      _priceController.clear();
    }
  }

  void _updateMenuItem(String docId) {
    final String itemName = _itemController.text.trim();
    final int? price = int.tryParse(_priceController.text.trim());

    if (itemName.isEmpty || price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid item and price')),
      );
      return;
    }

    FirebaseFirestore.instance
        .collection('resturants')
        .doc(_selectedRestaurantId)
        .collection('menus')
        .doc(docId)
        .update({
      'item': itemName,
      'price': price, 
    });
  }

  void _deleteMenuItem(String docId) {
    FirebaseFirestore.instance
        .collection('resturants')
        .doc(_selectedRestaurantId)
        .collection('menus')
        .doc(docId)
        .delete();
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> data, String docId) {
    _itemController.text = data['item'];
    _priceController.text = data['price'].toString();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Menu Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _itemController, decoration: const InputDecoration(hintText: 'Item')),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(hintText: 'Price'),
              keyboardType: TextInputType.number, 
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              _updateMenuItem(docId);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Menus')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('resturants').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final docs = snapshot.data!.docs;

                return DropdownButton<String>(
                  hint: const Text('Select Restaurant'),
                  value: _selectedRestaurantId,
                  onChanged: (value) {
                    setState(() {
                      _selectedRestaurantId = value;
                    });
                  },
                  items: docs
                      .map((doc) => DropdownMenuItem(
                            value: doc.id,
                            child: Text((doc.data() as Map<String, dynamic>)['name']),
                          ))
                      .toList(),
                );
              },
            ),

            if (_selectedRestaurantId != null) ...[
              TextField(controller: _itemController, decoration: const InputDecoration(hintText: 'Item')),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(hintText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _addMenuItem, child: const Text('Add Menu Item')),
              const Divider(),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('resturants')
                      .doc(_selectedRestaurantId)
                      .collection('menus')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    final docs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final data = docs[index].data() as Map<String, dynamic>;
                        final docId = docs[index].id;

                        return ListTile(
                          title: Text(data['item']),
                          subtitle: Text('Price: ${data['price']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showEditDialog(context, data, docId),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteMenuItem(docId),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
