import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/notes_page.dart';
import 'pages/quizzes_page.dart';
import 'pages/audio_page.dart';
import 'pages/profile_page.dart';
import 'dart:async'; // Required for timer in Splash Screen

void main() {
  runApp(NoteTeddApp());
}

class NoteTeddApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteTedd',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Start with the splash screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => MainScreen()), // Navigate to main screen
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
              Icons.pets, // Teddy bear icon from material icons
              size: 100,
              color: Colors.white,
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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    NotesPage(),
    QuizzesPage(),
    AudioPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quizzes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack),
            label: 'Audio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Customize active icon color
        unselectedItemColor: Colors.grey, // Customize inactive icon color
        showUnselectedLabels: true, // Show labels even for unselected items
        type: BottomNavigationBarType.fixed, // Ensures all icons are displayed
      ),
    );
  }
}
