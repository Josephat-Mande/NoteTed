import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool isRecording = false;
  String transcriptionText = "";

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

  Future<void> _startRecordingWithOpenAI() async {
    setState(() {
      isRecording = true;
      transcriptionText = "Recording...";
    });

    try {
      // Replace this with code to start actual recording if required
      // For example, use a plugin to record audio and save it as a file

      // Example of calling OpenAI's transcription endpoint
      final String audioFilePath = 'path/to/your/audio/file.wav';
      final transcription = await _transcribeAudioWithOpenAI(audioFilePath);

      setState(() {
        transcriptionText = transcription;
        isRecording = false;
      });
    } catch (error) {
      setState(() {
        transcriptionText = "Error during transcription. Please try again.";
        isRecording = false;
      });
      print("OpenAI error: $error");
    }
  }

  Future<String> _transcribeAudioWithOpenAI(String filePath) async {
    final url = Uri.parse("https://api.openai.com/v1/audio/transcriptions");
    final request = http.MultipartRequest("POST", url)
      ..headers["Authorization"] =
          "Bearer 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"
      ..files.add(await http.MultipartFile.fromPath("file", filePath))
      ..fields["model"] = "whisper-1";

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final data = json.decode(responseBody);

    if (response.statusCode == 200 && data["text"] != null) {
      return data["text"];
    } else {
      throw Exception(
          "Failed to transcribe audio: ${data['error'] ?? 'Unknown error'}");
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
            // Existing UI components for profile, performance, and quote
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
        onPressed: isRecording ? null : _startRecordingWithOpenAI,
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
}
