import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Import login page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pets, // Use a teddy bear icon from the Icon set
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'Note Tedd',
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your Tedd is here to write and read it for you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
                fontFamily: 'Cursive', // Fancy font
              ),
            ),
          ],
        ),
      ),
    );
  }
}
