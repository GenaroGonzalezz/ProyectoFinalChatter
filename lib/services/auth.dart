// TODO Implement this library.
import 'package:chatternet/models/Chat.dart';
import 'package:chatternet/models/user.dart';
import 'package:chatternet/screens/home.dart';
import 'package:chatternet/screens/login_screen.dart';
import 'package:chatternet/views/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MegaUser? _userFromFirebaseUser(User user) {
    return user != null ? MegaUser(uid: user.uid) : null;
  }
  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Home();
    } else {
      return LoginScreen();
    }
  }
}


//
//   Future signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       User user = result.user!;
//       return _userFromFirebaseUser(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future signUpWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User user = result.user!;
//       return _userFromFirebaseUser(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future resetPass(String email) async {
//     try {
//       return await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future<User> signInWithGoogle(BuildContext context) async {
//     final GoogleSignIn _googleSignIn = new GoogleSignIn();
//
//     final GoogleSignInAccount googleSignInAccount =
//     (await _googleSignIn.signIn())!;
//     final GoogleSignInAuthentication googleSignInAuthentication =
//     await googleSignInAccount.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);
//
//     UserCredential result = await _auth.signInWithCredential(credential);
//     User userDetails = result.user!;
//
//     if (result == null) {
//     } else {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//     }
//     return userDetails;
//   }
//
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
//
// class ServicioAuth {
//   final FirebaseAuth _auth;
//
//   ServicioAuth(this._auth);
//
//   Stream<User?> get authStateChanges => _auth.idTokenChanges();
//
//   Future<String?> login(String email, String password) async {
//     try{
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return "Logged In";
//     } catch(e) {
//       //return e;
//     }
//   }
//
//   Future<String?>? signUp(String email, String password) async {
//     try{
//       await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
//         User? user = FirebaseAuth.instance.currentUser;
//
//         await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
//           'uid': user?.uid,
//           'email': email,
//           'password': password,
//         });
//       });
//       return "Signed Up";
//     } catch(e) {
//      // return e;
//     }
//   }
// }