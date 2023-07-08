import 'package:chatapp/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widget/message_bubble.dart';

class MessageFriends extends StatelessWidget {
  const MessageFriends({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator()
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error 404'),
            );
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
              itemCount: users.length,
              itemBuilder: ((context, index) {
                final user = users[index].data();
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => ChatScreen(recieverid: user['uid']))),
                  child: Container(
                   
                    height: 50,
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius:20 , foregroundImage: NetworkImage(user['image_url'])),
                            SizedBox(width: 10,),
                          Text(
                          user['username'],
                          style: const TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                );
              }));
        },
      ),
    );
  }
}
