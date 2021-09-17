import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthenticationRepository({
    CacheClient cache,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email already in use, Try with different Email";
      } else if (e.code == "invalid-email") {
        return "Invalid email!";
      } else if (e.code == "account-exists-with-different-credential") {
        return "Account already logged in";
      } else if (e.code == "weak-password") {
        return "Password must be more than 6 characters";
      } else {
        print(e.code);
        return "Unidentified Error, Try again!";
      }
    }
  }

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await Future.wait([
      _firebaseAuth.signOut(),
    ]);

    // preferences.remove('userId');
  }

  Future login({String email, String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      firebase_auth.User user =
          (await firebase_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
              .user;
      // preferences.setString('userId', user.uid);
      // print(preferences.getString('userId'));
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Account does not exists!";
      } else if (e.code == "wrong-password") {
        return "Invalid Password!";
      } else if (e.code == "too-many-requests") {
        return "Too many requests. Please wait!";
      } else {
        print(e.code);
        return "Unidentified Error, Try again!";
      }
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}
