import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasestorage/userscreens/sign.dart';
import 'package:firebasestorage/uiscreens/profilescreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    if (email.text.isEmpty || !email.text.contains('@')) {
      _showMessage('Enter a valid email');
      return;
    }
    if (password.text.isEmpty) {
      _showMessage('Enter your password');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? 'Login failed');
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
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              const Text(
                "Login to your account",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text("Don't have an account? Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
