
import 'package:flutter/material.dart';
import 'package:flashh/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  

  String? message;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessageStream() async {
    await for (var j
        in FirebaseFirestore.instance.collection('messages').snapshots()) {
      for (var i in j.docs) {
        print(i.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                MessageStream();
                 FirebaseAuth.instance.signOut();
                 Navigator.pop(context);
              }),
        ],
        title: Text(
          '⚡️Chat',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageController.clear();
                      FirebaseFirestore.instance.collection('messages').add({
                        'text': message,
                        'sender': loggedInUser!.email,
                        'created': Timestamp.now(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  void printf() {
    print('message stream called');
  }


  @override 
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages').orderBy('created').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<MessageBubble> mess = [];
          final message = snapshot.data!.docs.reversed.map((messages) {
            final textMessage = messages['text'];
            final messageSender = messages['sender'];
            final currentUser = loggedInUser!.email;
             

            return MessageBubble(
                textMessage: textMessage,
                messageSender: messageSender,
                isMe: currentUser==messageSender,);
          });
          for (var i in message) {
            mess.add(i);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: mess,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  String? textMessage;
  String? messageSender;
  bool isMe;
  MessageBubble({this.textMessage, this.messageSender, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(
            messageSender!,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
          Material(
            borderRadius: isMe? BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)):
                BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))
                ,
            elevation: 7,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(textMessage!,
                  style: TextStyle(color: Colors.white, fontSize: 17)),
            ),
          ),
        ],
      ),
    );
  }
}
