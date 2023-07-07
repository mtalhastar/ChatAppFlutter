import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/widget/pickimage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final firebase = FirebaseAuth.instance;
  bool isLogin = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  File? image;
  bool showForm = false;
  double maxHeight = 450;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showForm = true;
      });
    });
    super.initState();
  }

  void saveItem() async {
    final validation = _formKey.currentState!.validate();
    if (!validation) {
      return;
    }
    _formKey.currentState!.save();
    try {
      if (!isLogin) {
        final usercredentials = await firebase.signInWithEmailAndPassword(
            email: email, password: password);
        print(usercredentials);
      } else {
        final usercredential = await firebase.createUserWithEmailAndPassword(
            email: email, password: password);
        print(usercredential);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${usercredential.user!.uid}.jpg');

        await storageRef.putFile(image!);
        final imageurl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(usercredential.user!.uid)
            .set({'username': username, 'email': email, 'image_url': imageurl});
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')));
    }
    print(email);
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      maxHeight = 220;
    } else {
      maxHeight = 420;
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.blue, Colors.deepPurpleAccent])),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/chat.png')),
              const SizedBox(
                height: 26,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                height: showForm ? maxHeight : 0,
                curve: Curves.fastEaseInToSlowEaseOut,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: showForm
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (isLogin)
                            ImagePickerS(
                              addimage: (value) {
                                image = value;
                              },
                            ),
                          if (isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'username',
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().length <= 0 ||
                                    value.isEmpty) {
                                  return 'Invalid username';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                username = value!;
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().length <= 0 ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email = value!;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().length <= 0 ||
                                  value.isEmpty) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: saveItem,
                            child: Text(isLogin ? 'Signup' : 'Login'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(isLogin
                                  ? 'Already Have an account?'
                                  : 'Create an account'))
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
