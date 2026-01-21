import 'package:firebasestorage/adminscreens/menus.dart';

import 'package:firebasestorage/adminscreens/resturants.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard"),leading:IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          }),),
      body: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>ManageMenus(restaurantId: '', restaurantName: '',)));
            
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu, size: 40),
                  SizedBox(height: 8),
                  Text("Manage Menus", textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>ManageRestaurants()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.store, size: 40),
                  SizedBox(height: 8),
                  Text("Manage Restaurants", textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        
              
            
            
          
        ],
      ),
    );
  }
}
