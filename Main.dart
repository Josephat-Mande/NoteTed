
import 'package:flutter/material.dart';

void main() {
  runApp(NoteSummarizerApp());
}

class NoteSummarizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classroom Note Summarizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteHomePage(),
    );
  }
}

class NoteHomePage extends StatefulWidget {
  @override
  _NoteHomePageState createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  final TextEditingController _noteController = TextEditingController();
  final List<String> _summaries = [];

  void _summarizeNote() {
    String note = _noteController.text.trim();
    if (note.isNotEmpty) {
      setState(() {
        _summaries.add(note); // Here, we simply add the note as is; in a real app, you'd summarize it
      });
      _noteController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note summarized and saved!')),
      );
    }
  }

  void _deleteSummary(int index) {
    setState(() {
      _summaries.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Summary deleted!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom Note Summarizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Enter your classroom notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _summarizeNote,
              child: Text('Summarize Note'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _summaries.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(_summaries[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteSummary(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
