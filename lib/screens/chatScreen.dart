import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/widget/InputWidget.dart';
import 'package:chatapp/widget/ShowMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() {
    // TODO: implement createState
    return _ChatScreen();
  }
}

class _ChatScreen extends State<ChatScreen> {
  void setupNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print(token);
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    setupNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Chatify',
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
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ShowMessagePage(), InputW()]))),
    );
  }
}
