import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputW extends StatefulWidget {
  const InputW({super.key, required this.receiverId});
  final String receiverId;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputW();
  }
}

class _InputW extends State<InputW> {
  TextEditingController textController = TextEditingController();
  void handleButtonPress() async {
    String inputValue = textController.text;
    if (inputValue.trim().isEmpty) {
      return;
    }
    final user = await FirebaseAuth.instance.currentUser;
    final participants = [user!.uid, widget.receiverId];
    final userinfo = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': inputValue,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userinfo.data()!['username'],
      'image': userinfo.data()!['image_url'],
      'recieverId': widget.receiverId,
      'participants': participants
    });

    textController.clear();
    // Do something with the input value
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Message',
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: handleButtonPress,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );

    // TODO: implement build
  }
}
