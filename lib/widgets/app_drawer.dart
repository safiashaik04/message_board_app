import 'package:flutter/material.dart';
import '../screens/boards_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Menu", style: TextStyle(fontSize: 24)),
          ),
          ListTile(
            title: Text("Message Boards"),
            onTap: () {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => BoardsScreen()));
            },
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
          ListTile(
            title: Text("Settings"),
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (_) => SettingsScreen()));
            },
          ),
        ],
      ),
    );
  }
}
