import 'dart:io';

import 'package:chat/ui/components/chat_message.dart';
import 'package:chat/ui/components/text_compose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? _currentUser;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<User?> _getUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication?.idToken,
        accessToken: googleSignInAuthentication?.accessToken,
      );

      final UserCredential userCredentialResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredentialResult.user;

      return user;
    } catch (error) {
      return null;
    }
  }

  void _sendMessage({String? text, XFile? imgFile}) async {
    final User? user = _currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Não foi possível fazer o login. Tente novamente!"),
          backgroundColor: Colors.red,
        ),
      );
    }

    Map<String, dynamic> data = {
      "uid": user!.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoURL,
      "time": Timestamp.now(),
    };

    if (imgFile != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(
            user.uid + DateTime.now().microsecondsSinceEpoch.toString(),
          )
          .putFile(File(imgFile.path));

      setState(() {
        _isLoading = true;
      });

      TaskSnapshot taskSnapshot = await task.whenComplete(() {});
      String url = await taskSnapshot.ref.getDownloadURL();

      data['imgUrl'] = url;

      setState(() {
        _isLoading = false;
      });
    }

    if (text != null) data['text'] = text;

    FirebaseFirestore.instance.collection("messages").add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: _currentUser == null,
        backgroundColor: Colors.blue,
        title: Text(_currentUser != null
            ? "Olá, ${_currentUser?.displayName}"
            : "Chat App"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        elevation: 0,
        actions: [
          _currentUser != null
              ? IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    googleSignIn.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Você foi desconectado..."),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ))
              : IconButton(onPressed: () async {
                await _getUser();
          }, icon: const Icon(Icons.login, color: Colors.white,)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("messages")
                    .orderBy("time")
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<QueryDocumentSnapshot> documents =
                          snapshot.data!.docs.reversed.toList();
                      return ListView.builder(
                          itemCount: documents.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> messages =
                                documents[index].data() as Map<String, dynamic>;
                            return ChatMessage(messages, messages['uid'] == _currentUser?.uid);
                          });
                  }
                }),
          ),
          _isLoading ? const LinearProgressIndicator() : Container(),
          _currentUser != null ? TextCompose(_sendMessage) : Container()
        ],
      ),
    );
  }
}
