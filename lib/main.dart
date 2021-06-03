
import 'package:chatternet/screens/about_us.dart';
import 'package:chatternet/screens/configuracion.dart';
import 'package:chatternet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:chatternet/screens/welcome_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:chatternet/screens/login_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:chatternet/screens/registration_screen.dart';
import 'package:chatternet/screens/chat_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helper/helperfunctions.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(Chatternoot());
}

class Chatternoot extends StatefulWidget {
  @override
  _ChatternootState createState() => _ChatternootState();
}

class _ChatternootState extends State<Chatternoot> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  late final bool userIsLoggedIn;

  // @override
  // void initState() {
  //   getLoggedInState();
  //   super.initState();
  // }

  // getLoggedInState() async {
  //   await HelperFunctions.getUserLoggedInSharedPreference().then((value){
  //     setState(() {
  //       userIsLoggedIn  = value!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.light().copyWith(
      //   textTheme: TextTheme(
      //     body1: TextStyle(color: Colors.black54),
      //   ),
      // ),
        debugShowCheckedModeBanner: false,

        home:
        //userIsLoggedIn != null ? userIsLoggedIn ? Home() : WelcomeScreen() : WelcomeScreen(),
        WelcomeScreen(),
        initialRoute: WelcomeScreen.id,
        routes: {
          // '/': (context) => WelcomeScreen(),
          // '/Login': (context) => LoginScreen(),
          // '/Register': (context) => RegistrationScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          Configuracion.id: (context) => Configuracion(),
          Acerca.id: (context) => Acerca(),
          Home.id: (context) => Home(),

        });
  }
}
