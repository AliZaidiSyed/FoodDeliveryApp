import 'package:flutter/material.dart';
import 'package:firebasestorage/userscreens/login.dart';
import 'package:firebasestorage/userscreens/sign.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("WELCOME PAGE"),leading:IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); 
          }),),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome To The Food Delivery App',
              style: TextStyle(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // ✅ Register Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Login Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
