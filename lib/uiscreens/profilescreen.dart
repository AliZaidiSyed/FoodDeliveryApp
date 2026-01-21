import 'package:firebasestorage/adminscreens/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:firebasestorage/uiscreens/cart.dart';

import 'package:firebasestorage/uiscreens/home.dart';


import 'package:firebasestorage/userscreens/welcome.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            
            const SizedBox(height: 10),
            const Text(
              ' M.ALI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ListTile(
              title: const Text('HOME PAGE'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),

          
            ListTile(
              title: const Text('CART'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),

  

            ListTile(
              title: const Text('Exit'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
