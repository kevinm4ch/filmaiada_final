import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppAuthProvider extends ChangeNotifier {
  bool _isSigningIn = false;
  String? _error;
  File? _image;

  File? get image => _image;

  set image(File? image) {
    _image   = image;
    notifyListeners();
  }

  String? get error => _error;
  bool get isSigningIn => _isSigningIn;

  Future<void> signInWithGoogle() async {
    _isSigningIn = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId:
                  "757075726048-q4e2moam07bpnp7lft3ohmlq6bko8r50.apps.googleusercontent.com")
          .signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      _error = 'Erro ao realizar o login:\n$e';
      notifyListeners();
    } finally {
      _isSigningIn = false;
      notifyListeners();
    }
  }
}
