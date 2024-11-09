import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
// Import Gemini AI SDK (pseudo-code as the actual package may vary)
import 'package:gemini_ai/gemini_ai.dart';

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
  bool isRecording = false; // To track recording state
  String transcriptionText = ""; // Stores transcription result

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

  Future<void> _startRecordingWithGemini() async {
    setState(() {
      isRecording = true;
      transcriptionText = "Recording..."; // Display recording status
    });

    try {
      // Start recording and transcription using Gemini AI SDK
      String result = await GeminiAI.startTranscription();

      setState(() {
        transcriptionText = result;
        isRecording = false;
      });
    } catch (error) {
      setState(() {
        transcriptionText = "Error during transcription. Please try again.";
        isRecording = false;
      });
      print("Gemini AI error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

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
            onPressed: _logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: isSmallScreen ? 30 : 40,
                  backgroundImage: AssetImage('../assets/avatar.png'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $username!',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 24 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Ready to conquer today?',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 14 : 16,
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
            Text(
              'Your Weekly Performance',
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 18 : 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
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
                SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    'Quizzes Suggested',
                    '12',
                    Icons.quiz,
                    Colors.green,
                    screenWidth,
                  ),
                ),
                SizedBox(width: 10),
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
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
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
                      fontSize: isSmallScreen ? 16 : 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '- B.B. King',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            if (transcriptionText.isNotEmpty) ...[
              Text(
                'Transcription:',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 18 : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                transcriptionText,
                style: GoogleFonts.poppins(fontSize: isSmallScreen ? 14 : 16),
              ),
            ]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isRecording ? null : _startRecordingWithGemini,
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.mic, color: Colors.white),
        label: Text(
          isRecording ? 'Recording...' : 'Record Lesson',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon, Color color,
      double screenWidth) {
    bool isSmallScreen = screenWidth < 600;
    double cardWidth = isSmallScreen ? screenWidth / 3.5 : 120;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: cardWidth,
        height: isSmallScreen ? 120 : 140,
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
            Icon(icon, size: isSmallScreen ? 30 : 36, color: color),
            SizedBox(height: 8),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 24 : 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 12 : 14,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
