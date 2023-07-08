import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/widget/InputWidget.dart';
import 'package:chatapp/widget/usersForchat.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() {
    // TODO: implement createState
    return _ChatScreen();
  }
}

class _ChatScreen extends State<UserScreen> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Friends',
              style: TextStyle(color: Color.fromARGB(255, 138, 224, 255)),
            ),
            backgroundColor: Color.fromARGB(255, 8, 1, 36),
            actions: [
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 133, 210, 255),
                  )),
            ],
          ),
          body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.deepPurpleAccent])),
              child: const MessageFriends())),
    );
  }
}
