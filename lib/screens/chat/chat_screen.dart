import 'package:flutter/material.dart';
import '../../models/message.dart';

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(id: 1, senderId: 1, receiverId: 2, content: 'Bonjour, je souhaite acheter vos tomates.'),
    Message(id: 2, senderId: 2, receiverId: 1, content: 'Bonjour, combien voulez-vous ?'),
  ];

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg.senderId == 1 ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: msg.senderId == 1 ? Colors.green[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(msg.content),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: messageController, decoration: InputDecoration(hintText: 'Écrire un message'))),
                IconButton(onPressed: () { /* TODO: Envoyer message */ }, icon: Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
