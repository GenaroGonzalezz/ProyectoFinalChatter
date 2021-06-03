// import 'dart:async';
// import 'dart:convert' show json;
// import 'package:animate_do/animate_do.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:chatternet/models/Loading.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import "package:http/http.dart" as http;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:chatternet/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'home.dart';
// //import 'package:chatternet/Components/rounded_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'chat_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:flutter_signin_button/flutter_signin_button.dart';
//
// class InicioSesionGoogle extends StatefulWidget {
//   InicioSesionGoogle({required Key key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   _InicioSesionGoogleState createState() => _InicioSesionGoogleState();
// }
//
// class _InicioSesionGoogleState extends State<InicioSesionGoogle> {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   late SharedPreferences prefs;
//
//   bool isLoading = false;
//   bool isLoggedIn = false;
//   late User currentUser;
//
//   @override
//   void initState() {
//     super.initState();
//     isSignedIn();
//   }
//
//   void isSignedIn() async {
//     this.setState(() {
//       isLoading = true;
//     });
//
//     prefs = await SharedPreferences.getInstance();
//
//     isLoggedIn = await googleSignIn.isSignedIn();
//     if (isLoggedIn) {
//     //   Navigator.push(
//     //     context,
//     //     MaterialPageRoute(builder: (context) => Home(currentUserId: prefs.getString('id'))),
//     //   );
//     // }
//
//     this.setState(() {
//       isLoading = false;
//     });
//   }
//
//   Future<Null> handleSignIn() async {
//     prefs = await SharedPreferences.getInstance();
//
//     this.setState(() {
//       isLoading = true;
//     });
//
//     GoogleSignInAccount googleUser = (await googleSignIn.signIn())!;
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     User firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user!;
//
//     if (firebaseUser != null) {
//       // Check is already sign up
//       final QuerySnapshot result =
//       await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).get();
//       final List<DocumentSnapshot> documents = result.docs;
//       if (documents.length == 0) {
//         // Update data to server if new user
//         FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set({
//           'nickname': firebaseUser.displayName,
//           'photoUrl': firebaseUser.photoURL,
//           'id': firebaseUser.uid,
//           'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
//           'chattingWith': null
//         });
//
//         // Write data to local
//         currentUser = firebaseUser;
//         await prefs.setString('id', currentUser.uid);
//         await prefs.setString('nickname', currentUser.displayName!);
//         await prefs.setString('photoUrl', currentUser.photoURL!);
//       } else {
//         // Write data to local
//         await prefs.setString('id', documents[0].data()!['id']);
//         await prefs.setString('nickname', documents[0].data()!['nickname']);
//         await prefs.setString('photoUrl', documents[0].data()!['photoUrl']);
//         await prefs.setString('aboutMe', documents[0].data()!['aboutMe']);
//       }
//       Fluttertoast.showToast(msg: "Sign in success");
//       this.setState(() {
//         isLoading = false;
//       });
//
//       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(currentUserId: firebaseUser.uid)));
//     } else {
//       Fluttertoast.showToast(msg: "Sign in fail");
//       this.setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             widget.title,
//             style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: Stack(
//           children: <Widget>[
//             Center(
//               child: FlatButton(
//                   onPressed: () => handleSignIn().catchError((err) {
//                     Fluttertoast.showToast(msg: "Sign in fail");
//                     this.setState(() {
//                       isLoading = false;
//                     });
//                   }),
//                   child: Text(
//                     'SIGN IN WITH GOOGLE',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                   color: Color(0xffdd4b39),
//                   highlightColor: Color(0xffff7f7f),
//                   splashColor: Colors.transparent,
//                   textColor: Colors.white,
//                   padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)),
//             ),
//
//             // Loading
//             Positioned(
//               child: isLoading ? const Loading() : Container(),
//             ),
//           ],
//         ));
//   }
// }
//
