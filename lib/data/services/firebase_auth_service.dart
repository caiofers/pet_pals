import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_pals/data/services/firebase_database_service.dart';
import 'package:pet_pals/domain/entities/exceptions/auth_exception.dart';
import 'package:pet_pals/domain/enums/auth_error_code_enum.dart';

class FirebaseAuthService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  User? firebaseUser;
  bool isLoading = true;

  final service = FirebaseDatabaseService();

  FirebaseAuthService() {
    _authCheck();
  }

  _authCheck() {
    _firebaseAuth.authStateChanges().listen((user) {
      firebaseUser = user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    firebaseUser = _firebaseAuth.currentUser;
    notifyListeners();
  }

  registerEmailPassword(
      String name, String? imagePath, String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firebaseAuth.currentUser?.updateDisplayName(name);
      if (imagePath != null) {
        try {
          String? url = await service.uploadImage(imagePath);
          await _firebaseAuth.currentUser?.updatePhotoURL(url);
        } catch (e) {
          rethrow;
        }
      }
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(AuthErrorCode.weakPassword.message);
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(AuthErrorCode.emailAlreadyInUse.message);
      } else {
        rethrow;
      }
    }
  }

  loginEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(AuthErrorCode.userNotFound.message);
      } else if (e.code == 'wrong-password') {
        throw AuthException(AuthErrorCode.wrongPassword.message);
      } else {
        rethrow;
      }
    }
  }

  logout() async {
    await _firebaseAuth.signOut();
  }
}
