import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets_auth/auth_form.dart';

class AuthScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
   UserCredential? authResult;
  void _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx) async {
    try {
      if (isLogin) {
        authResult = await _auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password,
        );
      }
    }
    on FirebaseAuthException catch (e) {
      String message = "error Occurred";

      if (e.code == 'weak-password') {
        message='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message='The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message='wrong password provided for that user.';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(content: Text(message),
      backgroundColor: Colors.yellow,
      )
      );
    } catch (e) {
      print(e);
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.pink,
        body: AuthForm(_submitAuthForm),
      );
    }
  }
