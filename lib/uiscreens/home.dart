import 'package:firebasestorage/models/home_model.dart';
import 'package:firebasestorage/uiscreens/menu.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeModel homeModel = HomeModel();

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    await homeModel.fetchRestaurants();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          }),
        title: const Text("Welcome to Home Page"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: homeModel.data.length,
        itemBuilder: (ctx, index) {
          final restaurant = homeModel.data[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuScreen(restaurantId: restaurant['id'], restaurantName: restaurant['name']),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: restaurant['imageurl'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(restaurant['imageurl'], width: 60, height: 60, fit: BoxFit.cover),
                      )
                    : null,
                title: Text(
                  restaurant["name"],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(restaurant['description']),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}
