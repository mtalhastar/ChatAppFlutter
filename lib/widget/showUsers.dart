import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widget/message_bubble.dart';
class ShowUsers extends StatelessWidget {
  const ShowUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    return const Expanded(
      child: Center(
        child: Text('No added people to show'),
      )
    );
  }
}