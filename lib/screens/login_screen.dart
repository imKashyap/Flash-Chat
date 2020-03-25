import 'package:flash_chat/components/roundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id='LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner=false;
  String email;
  String password;
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.white,
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
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
                height: 35.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email=value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email'
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration:kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password'
                )
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Log in',
                color: Colors.blueAccent,
                onTap: ()async {
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null)
                      Navigator.pushNamed(context, ChatScreen.id);
                  }
                  catch(e){
                    print(e);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
