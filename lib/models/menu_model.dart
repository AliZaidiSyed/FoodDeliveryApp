import 'package:cloud_firestore/cloud_firestore.dart';

class MenuModel {
  List<Item> items = [];
  final String restaurantId;

  MenuModel({required this.restaurantId});

  Future<void> fetchMenu() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('resturants')
        .doc(restaurantId)
        .collection("menus")
        .get();

    items = snapshot.docs
        .map((doc) => Item(
              name: doc['item'],
              price: doc['price'], // price from Firestore (int)
            ))
        .toList();
  }

  Item getByPosition(int index) => items[index];
  int get length => items.length;
}

class Item {
  final String name;
  final int price; 

  Item({required this.name, required this.price});

  @override
  bool operator ==(Object other) => other is Item && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
