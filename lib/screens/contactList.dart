import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getContactsPermission();
  }

  void getContactsPermission() async {
    if (await FlutterContacts.requestPermission()) {
      _getContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  void _getContacts() async {
    final fetchingContacts = await FlutterContacts.getContacts();

    setState(() {
      contacts = fetchingContacts;
    });

    print(contacts[0].displayName.toString());
    print(contacts.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Contacts',
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
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.deepPurpleAccent],
            ),
          ),
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                title: Text(
                  contact.displayName ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
                
              );
            },
          ),
        ),
      ),
    );
  }
}
