
import 'package:flutter/material.dart';
import 'package:flashh/screens/buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashh/constants.dart';
import 'package:flashh/screens/login_screen.dart';
import 'package:flashh/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                ),
               
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText('Flash Chat',
                  
                   
                   textStyle: TextStyle(
                     fontSize: 40,
                          fontWeight: FontWeight.w900,
                           color: Colors.black),
                  ),
                  
                  
                ])
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            buttons(buttonColor: kLoginButtonColor,
            buttonText: kLoginText,
            onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);

            },),
            buttons(buttonColor: kRegisterButtonColor,
             buttonText: kRegisterText,
             onPressed: (){
             Navigator.pushNamed(context, RegistrationScreen.id);
             },),

          ],
        ),
      ),
    );
  }
}

