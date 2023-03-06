import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mow/data/models/user.dart';

class UserFirestoreProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserGlobal? user;

  //update user token
  Future updateToken(String? token) async {
    await _firestore
        .collection('USERS')
        .doc('LkNbRjLsPddukQDL26bz')
        .update({'token': token});
  }

  //firebase auth register user with email and password
  Future<bool> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //firebase auth login with email and password
  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => getUser(user?.uid));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //get user data
  Future<void> getUser(String? uid) async {
    final querySnapshot = await _firestore.collection('USERS').doc(uid).get();

    user = UserGlobal.fromFirestore(querySnapshot.data()!);

    notifyListeners();
  }
}
