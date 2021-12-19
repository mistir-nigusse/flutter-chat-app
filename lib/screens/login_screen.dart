import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashh/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:flashh/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email;
  var password;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kDecoration.copyWith(hintText: kEmailHintText)),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      kDecoration.copyWith(hintText: kPasswordHintText)),
              SizedBox(
                height: 24.0,
              ),
              buttons(
                buttonColor: kLoginButtonColor,
                buttonText: kLoginText,
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final currentUser = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);

                    if (currentUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        spinner = false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
