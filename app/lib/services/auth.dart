import 'package:firebase_auth/firebase_auth.dart';
import 'package:pay4/models/pay4user.dart';
import 'package:pay4/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Pay4User _createUser(User firebaseUser) {
    return firebaseUser != null ? Pay4User(uid: firebaseUser.uid) : null;
  }

  Stream<Pay4User> get user {
    return _auth.authStateChanges().map(_createUser);
  }

  // anon sign in
  Future signInAnon() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      return _createUser(authResult.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in
  Future signIn(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _createUser(authResult.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in
  Future register(String email, String password) async {
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: credentials.user.uid).updateUserData(0, 100.0);
      return _createUser(credentials.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
