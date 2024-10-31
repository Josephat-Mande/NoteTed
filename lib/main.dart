import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/notes_page.dart';
import 'pages/quizzes_page.dart';
import 'pages/audio_page.dart';
import 'pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart'; // Required for Firebase initialization
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth package
import 'pages/login_page.dart'; // Login page for unauthenticated users
import 'pages/signup_page.dart';
import 'dart:async'; // Required for timer in Splash Screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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
      home: SplashScreen(),
      // Start with the splash screen

      routes: {
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(), // Login page for unauthenticated users
        '/home': (context) => HomePage(),
        '/notes': (context) => NotesPage(),
        '/quizzes': (context) => QuizzesPage(),
        '/audio': (context) => AudioPage(),
        '/profile': (context) => ProfilePage(),
        // other routes
      },
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
    _checkAuthentication(); // Check if the user is authenticated
  }

  void _checkAuthentication() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 3 seconds

    // Get the current user from Firebase
    User? user = FirebaseAuth.instance.currentUser;

    // Navigate to the appropriate screen based on authentication status
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) =>
                LoginPage()), // Navigate to login page if unauthenticated
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) =>
                MainScreen()), // Navigate to main screen if authenticated
      );
    }
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

  void _logout() async {
    await FirebaseAuth.instance.signOut(); // Firebase logout
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (_) => LoginPage()), // Navigate back to login page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NoteTedd'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Logout functionality
          ),
        ],
      ),
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
            label: 'PlayNotes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Customize active icon color
        unselectedItemColor: Colors.black, // Customize inactive icon color
        showUnselectedLabels: true, // Show labels even for unselected items
        type: BottomNavigationBarType.fixed, // Ensures all icons are displayed
      ),
    );
  }
}
