import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar and Greeting
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('../assets/avatar.png'),
              ),
              SizedBox(width: 20),
              Text(
                'Hi, Joe!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 20),

          // Stats Section
          Text(
            'Your stats for the week',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('Lessons Recorded', '5', Colors.blue),
              _buildStatCard('Quizzes Suggested', '12', Colors.green),
              _buildStatCard('Audios Played', '7', Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color.withOpacity(0.2),
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
