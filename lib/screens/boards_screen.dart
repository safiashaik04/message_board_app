import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'chat_screen.dart';

class BoardsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> boards = [
    {'name': 'Games', 'icon': Icons.sports_esports},
    {'name': 'Business', 'icon': Icons.business_center},
    {'name': 'Public Health', 'icon': Icons.health_and_safety},
    {'name': 'Study', 'icon': Icons.menu_book},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message Boards"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(boards[index]['icon']),
            title: Text(boards[index]['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(boardName: boards[index]['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
