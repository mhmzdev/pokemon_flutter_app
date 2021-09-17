import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // create account
  Future signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user == null) {
        return null;
      }
      await user.updateDisplayName(name);
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        print("EMAIL VERIFICATION SENT!");
      }
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('userId', user.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email already in use, Try with different Email";
      } else if (e.code == "invalid-email") {
        return "Invalid email!";
      } else if (e.code == "account-exists-with-different-credential") {
        return "Account already logged in";
      } else if (e.code == "weak-password") {
        return "Password must be more than 6 characters";
      } else {
        return "Unidentified Error, Try again!";
      }
    }
  }

  // login
  Future login(String email, String password) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user == null) {
        return null;
      }
      preferences.setString('userId', user.uid);
      print(preferences.getString('userId'));
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Account does not exists!";
      } else if (e.code == "wrong-password") {
        return "Invalid Password!";
      } else if (e.code == "too-many-requests") {
        return "Too many requests. Please wait!";
      } else {
        return "Unidentified Error, Try again!";
      }
    }
  }

  // logout
  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.pop(context);
    preferences.remove('userId');
    await _firebaseAuth.signOut();
  }
}
