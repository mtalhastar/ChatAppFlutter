import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widget/message_bubble.dart';

class ShowMessagePage extends StatelessWidget {
  const ShowMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No messages'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('No messages'),
            );
          }

          final messages = snapshot.data!.docs;

          return ListView.builder(
              itemCount: messages.length,
              reverse: true,
              padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
              itemBuilder: ((context, index) {
                final chatMessage = messages[index].data();
                final nextMessage = index + 1 < messages.length
                    ? messages[index + 1].data()
                    : null;
                final currentMessageid = chatMessage['userId'];
                final nextmessageid =
                    nextMessage != null ? nextMessage['userId'] : null;
                final nextUserisSame = nextmessageid == currentMessageid;

                if (nextUserisSame) {
                  return MessageBubble.next(
                      message: chatMessage['text'],
                      isMe: authenticatedUser.uid == currentMessageid);
                } else {
                  return MessageBubble.first(
                      userImage: chatMessage['image'],
                      username: chatMessage['username'],
                      message: chatMessage['text'],
                      isMe: authenticatedUser.uid == currentMessageid);
                }
              }));
        },
      ),
    );
  }
}
