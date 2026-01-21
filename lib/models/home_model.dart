import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchRestaurants() async {
    final snapshot = await FirebaseFirestore.instance.collection('resturants').get();

    data = snapshot.docs.map((doc) {
      return {
        'id': doc.id,
        'name': doc['name'],
        'description': doc['description'],
       // 'imageurl': doc['imageurl'], 
      };
    }).toList();
  }
}
