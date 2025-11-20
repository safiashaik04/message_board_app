import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/app_drawer.dart';


class ChatScreen extends StatefulWidget {
  final String boardName;
  ChatScreen({required this.boardName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('boards')
        .doc(widget.boardName)
        .collection('messages')
        .add({
      'text': messageController.text.trim(),
      'timestamp': Timestamp.now(),
      'user': user?.email ?? 'Unknown',
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.boardName)),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('boards')
                  .doc(widget.boardName)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                final messages = snapshot.data!.docs;

                return ListView(
                  children: messages.map((msg) {
                    return ListTile(
                      title: Text(msg['text']),
                      subtitle: Text("${msg['user']} • ${msg['timestamp'].toDate()}"),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
