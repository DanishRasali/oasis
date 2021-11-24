import 'rest.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';

import '../app/locator.dart';
import '../models/user.dart';
import 'user_service.dart';

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final UserService _userService = locator<UserService>();

  var _currentUser;
  get currentUser => _currentUser;

  Future signInAnonymously() async {
    try {
      auth.UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();
      auth.User user = userCredential.user;
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      auth.User user = userCredential.user;
      await _populateCurrentUser(user);

      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future registerWithEmailAndPassword({
    @required String displayName,
    @required String email,
    @required String password,
    @required String phoneNumber,
    @required String type,
  }) async {
    try {
      auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      auth.User user = userCredential.user;

      _currentUser = User.createNew(
        id: user.uid,
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        type: type,
      );

      await _userService.createUser(_currentUser);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      return _populateCurrentUser(null);
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserSignedIn() async {
    auth.User user = _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future<void> _populateCurrentUser(auth.User user) async {
    if (user != null) {
      _currentUser = await _userService.getUser(id: user.uid);
    } else
      _currentUser = null;
  }

  Future<bool> validatePassword(String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: currentUser.email, password: password);
      return true;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = _firebaseAuth.currentUser;
    firebaseUser.updatePassword(password);
  }
}
