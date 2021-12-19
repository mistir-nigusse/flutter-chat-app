import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:flashh/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashh/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
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
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kDecoration.copyWith(hintText: kEmailHintText)),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
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
                buttonColor: kRegisterButtonColor,
                buttonText: kRegisterText,
                onPressed: () async {
                  try {
                    setState(() {
                      spinner = true;
                    });
                    final newUser = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email!, password: password!);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      spinner = false;
                    });
                    
                  }
                  
                   catch (e) {
                    print(e);
                  }

                  // print('registered');
                  // print(email);
                  // print(password);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
