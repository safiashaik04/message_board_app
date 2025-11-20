import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firstController = TextEditingController();
  final lastController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    firstController.text = doc['first_name'];
    lastController.text = doc['last_name'];
  }

  Future<void> updateUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'first_name': firstController.text,
      'last_name': lastController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: firstController, decoration: InputDecoration(labelText: "First Name")),
            SizedBox(height: 12),
            TextField(controller: lastController, decoration: InputDecoration(labelText: "Last Name")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: updateUser, child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
