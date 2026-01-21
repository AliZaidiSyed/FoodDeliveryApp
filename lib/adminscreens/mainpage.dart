import "package:firebasestorage/userscreens/welcome.dart";
import "package:flutter/material.dart";
import "package:firebasestorage/adminscreens/adminlogin.dart";
 import "package:firebasestorage/userscreens/welcome.dart"; 

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.yellow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "WELCOME TO FOOD DELIVERY APP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

      
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminLogin()),
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
                    'LOGIN AS ADMIN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

        
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
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
                    'LOGIN AS USER',
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
