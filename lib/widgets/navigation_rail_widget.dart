import 'package:flutter/material.dart';

class NavigationRailWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  NavigationRailWidget({required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelect,
      labelType: NavigationRailLabelType.all,
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(
            'assets/avatar.png'), // You can add an avatar image here.
      ),
      destinations: [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.note),
          label: Text('Notes'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.quiz),
          label: Text('Quizzes'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.audiotrack),
          label: Text('Audio'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Profile'),
        ),
      ],
    );
  }
}
