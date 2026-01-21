
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageRestaurants extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  ManageRestaurants({super.key});

  void _addRestaurant() {
    FirebaseFirestore.instance.collection('resturants').add({
      'name': _nameController.text,
      'description': _descController.text,
    });
    _nameController.clear();
    _descController.clear();
  }

  void _updateRestaurant(String docId) {
    FirebaseFirestore.instance.collection('resturants').doc(docId).update({
      'name': _nameController.text,
      'description': _descController.text,
    });
    _nameController.clear();
    _descController.clear();
  }

  void _deleteRestaurant(String docId) {
    FirebaseFirestore.instance.collection('resturants').doc(docId).delete();
  }

  void _showEditDialog(BuildContext context, Map<String, dynamic> data, String docId) {
    _nameController.text = data['name'];
    _descController.text = data['description'];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Restaurant'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(hintText: 'Name')),
            TextField(controller: _descController, decoration: const InputDecoration(hintText: 'Description')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              _updateRestaurant(docId);
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
      appBar: AppBar(title: const Text('Manage Restaurants')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(hintText: 'Restaurant Name')),
            TextField(controller: _descController, decoration: const InputDecoration(hintText: 'Description')),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _addRestaurant, child: const Text('Add Restaurant')),
            const Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('resturants').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final docId = docs[index].id;

                      return ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['description']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showEditDialog(context, data, docId),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteRestaurant(docId),
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
        ),
      ),
    );
  }
}
