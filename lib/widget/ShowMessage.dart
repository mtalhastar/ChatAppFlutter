import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widget/message_bubble.dart';

class ShowMessagePage extends StatelessWidget {
  const ShowMessagePage({super.key, required this.recieverId});
  final String recieverId;

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    print(authenticatedUser.uid);
    print(recieverId);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print('There is no data');
          return const Center(
            child: Text('No messages'),
          );
        }
        if (snapshot.hasError) {
          print('There is error');
          return const Center(
            child: Text('No messages'),
          );
        }

        final messages = snapshot.data!.docs;
        final newmessages = messages.where((message) {
          return message.data()['participants'].contains(recieverId) &&
              message.data()['participants'].contains(authenticatedUser.uid);
        }).toList();

        print(messages);

        return ListView.builder(
            itemCount: newmessages.length,
            reverse: true,
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            itemBuilder: ((context, index) {
              final chatMessage = newmessages[index].data();
              final nextMessage = index + 1 < newmessages.length
                  ? newmessages[index + 1].data()
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
    );
  }
}
