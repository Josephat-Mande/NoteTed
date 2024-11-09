import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('notes')
            .where('userId', isEqualTo: _auth.currentUser?.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title:
                    Text(doc['text'], style: GoogleFonts.poppins(fontSize: 16)),
                subtitle: Text(doc['createdAt'].toDate().toString(),
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
