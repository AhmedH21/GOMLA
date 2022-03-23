// import 'package:firebase_auth/firebase_auth.dart';
//
// class Auth {
//   final auth = FirebaseAuth.instance;
//
//   Future<UserCredential> signUp(String email, String password) async {
//     final authResult = await auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return authResult;
//   }
//
//   Future<UserCredential> signIn(String email, String password) async {
//     final authResult = await auth.createUserWithEmailAndPassword(
//         email: email, password: password);
//     return authResult;
//   }
//   Future<User> getUser() async {
//     return  auth.currentUser;
//   }
//
//   Future<void> signOut() async {
//     await auth.signOut();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<User> getUser() async {
    return  _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}