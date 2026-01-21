import 'package:flutter/material.dart';
import 'package:firebasestorage/adminscreens/adminboard.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  AdminLoginPageState createState() => AdminLoginPageState();
}

class AdminLoginPageState extends State<AdminLogin> {
  final email = TextEditingController();
  final password = TextEditingController();

  
  final String adminEmail = 'admin@admin.com';
  final String adminPassword = 'admin123';

  void login() {
    if (email.text.trim() == adminEmail && password.text == adminPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  AdminScreen()),
      );
    } else {
      _showMessage('Invalid admin credentials');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Login"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(top: 80.0, left: 24),
              child: Text(
                'ADMIN LOGIN',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: login,
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 