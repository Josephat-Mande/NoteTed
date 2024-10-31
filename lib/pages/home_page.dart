import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String username = 'User';
  String email = '';
  String userType = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          username = userDoc['username'] ?? 'User';
          email = userDoc['email'] ?? 'No email';
          userType = userDoc['type'] ?? 'N/A';
        });
      }
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen =
        screenWidth < 600; // Define small screens (e.g. phones)

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Dashboard',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout, // Log out function
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
            isSmallScreen ? 12.0 : 16.0), // Adjust padding for smaller screens
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar and Greeting
            Row(
              children: [
                CircleAvatar(
                  radius: isSmallScreen
                      ? 30
                      : 40, // Adjust avatar size for small screens
                  backgroundImage: AssetImage('../assets/avatar.png'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $username!',
                      style: GoogleFonts.poppins(
                        fontSize:
                            isSmallScreen ? 24 : 28, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ready to conquer today?',
                      style: GoogleFonts.poppins(
                        fontSize:
                            isSmallScreen ? 14 : 16, // Responsive font size
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Email: $email',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      'Type: $userType',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 12 : 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),

            // Stats Section Title
            Text(
              'Your Weekly Performance',
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 18 : 22, // Responsive font size
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),

            // Stats Cards Section (using Row and Expanded for proper responsiveness)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Lessons Recorded',
                    '5',
                    Icons.play_circle_fill,
                    Colors.blue,
                    screenWidth,
                  ),
                ),
                SizedBox(width: 10), // Spacing between cards
                Expanded(
                  child: _buildStatCard(
                    'Quizzes Suggested',
                    '12',
                    Icons.quiz,
                    Colors.green,
                    screenWidth,
                  ),
                ),
                SizedBox(width: 10), // Spacing between cards
                Expanded(
                  child: _buildStatCard(
                    'Audios Played',
                    '7',
                    Icons.audiotrack,
                    Colors.purple,
                    screenWidth,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Motivational Quote or Tip Section
            Container(
              padding:
                  EdgeInsets.all(isSmallScreen ? 16 : 20), // Responsive padding
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    '"The beautiful thing about learning is that nobody can take it away from you."',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 16 : 18, // Responsive font size
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '- B.B. King',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 12 : 14, // Responsive font size
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button for recording a lesson
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showRecordLessonDialog(context);
        },
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.mic, color: Colors.white),
        label: Text(
          'Record Lesson',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // Improved Stat Card Widget with icons and responsive design
  Widget _buildStatCard(String title, String count, IconData icon, Color color,
      double screenWidth) {
    bool isSmallScreen = screenWidth < 600; // Define small screens
    double cardWidth = isSmallScreen
        ? screenWidth / 3.5
        : 120; // Adjust card width for smaller screens

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: cardWidth, // Responsive card width
        height:
            isSmallScreen ? 120 : 140, // Adjust card height for smaller screens
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.2), color.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: isSmallScreen ? 30 : 36,
                color: color), // Responsive icon size
            SizedBox(height: 8),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 24 : 28, // Responsive font size
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 12 : 14, // Responsive font size
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show dialog for recording lesson
  void _showRecordLessonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Record New Lesson',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Start recording your lesson by pressing the button below.',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle recording functionality here
                },
                icon: Icon(Icons.mic, color: Colors.white),
                label: Text('Start Recording',
                    style: GoogleFonts.poppins(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }
}
