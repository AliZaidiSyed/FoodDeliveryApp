import 'package:flutter/material.dart';
import 'package:firebasestorage/userscreens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signup() async {
    if (email.text.trim().isEmpty || !email.text.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return;
    }

    if (name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your full name")),
      );
      return;
    }

    if (password.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password should be at least 6 characters")),
      );
      return;
    }

    if (password.text.trim() != confirmpassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.code}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.blue,
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 24),
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140.0),
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: name,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      TextField(
                        controller: confirmpassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: signup,
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          "Already have an account? Sign in",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
