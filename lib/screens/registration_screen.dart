import 'dart:async';
import 'dart:convert' show json;

import 'package:animate_do/animate_do.dart';
import 'package:chatternet/screens/home.dart';
import 'package:chatternet/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import "package:http/http.dart" as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:chatternet/constants.dart';
import 'package:flutter/material.dart';
//import 'package:chatternet/Components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../Components/rounded_button.dart';
import '../constants.dart';
import 'chat_screen.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:chatternet/screens/configuracion.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool isLoading = false;
  bool _displayNameValid = true;

  User? loggedInUser = FirebaseAuth.instance.currentUser;


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? username;

  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Firebase auth;
  bool isUserSignedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  bool showSpinner = false;
   late String email;
   late String password;
   late String nombre;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if(_currentUser == account){
        Navigator.pushNamed(context, ChatScreen.id);
      }

      //if (_currentUser != null) {
        //_handleGetContact(_currentUser!);
      //}
    });
    getUser().then((user) {
     // if (user != null) {
        // send the user to the home page
        // homePage();
      }
    //}
    );
    _googleSignIn.signInSilently();
  }
  // Future<void> _handleGetContact(GoogleSignInAccount user) async {
  //   setState(() {
  //     _contactText = "Cargando informacion de contacto...";
  //   });
  //   final http.Response response = await http.get(
  //     Uri.parse('https://people.googleapis.com/v1/people/me/connections'
  //         '?requestMask.includeField=person.names'),
  //     headers: await user.authHeaders,
  //   );
    // if (response.statusCode != 200) {
    //   setState(() {
    //     // _contactText = "People API gave a ${response.statusCode} "
    //     //     "response. Check logs for details.";
    //   });
    //   print('People API ${response.statusCode} response: ${response.body}');
    //   return;
    // }
    // final Map<String, dynamic> data = json.decode(response.body);
    // final String? namedContact = _pickFirstNamedContact(data);
    // setState(() {
    //   if (namedContact != null) {
    //     _contactText = "Hola $namedContact!";
    //   } else {
    //     _contactText = "No hay contactos para mostrar.";
    //   }
    //});
  //}
  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'];
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }
  Future<void> _handleSignIn() async {
    User? user;
    //await _googleSignIn.signIn();
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn){
      MaterialPageRoute(
          builder: (context) =>
              Home());
    }

    //
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             ChatScreen()));
    // // try {
    //   _googleSignIn.isSignedIn();
    //   if(isSignedIn) {
    //     Navigator.push(
    //         context,
            // MaterialPageRoute(
            //     builder: (context) =>
            //         ChatScreen())
        //);
        //Navigator.pushNamed(context, ChatScreen.id);
        //usuario = auth;
        // final newUser =
        // await _auth.createUserWithEmailAndPassword(
        //     email: email, password: password);
        // ignore: unnecessary_null_comparison

      // }
      // else if (!isSignedIn){
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) =>
      //               WelcomeScreen()));
      // }

    // } catch (error) {
    //   print(error);
    // }
  }
  Future<void> _handleSignOut() async {
   _googleSignIn.disconnect();
   await Navigator.pushNamed(context, WelcomeScreen.id);
}
// ================Fin Google Sign In===============
  late AnimationController giro;
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(FocusNode());}, //Si tocas cualquier otro lugar se esconde el teclado c:
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title:  Text("Regístrate"),
          //backgroundColor: Color(0xff1a888b),
          backgroundColor: Color(0xff226974),
          //elevation: 90,
          toolbarHeight: 55,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          actions: [
            SpinPerfect(
              animate: true,
              controller: (controller) => giro = controller,
              child: Hero(tag: 'logo', child: IconButton(
                icon: Image.asset('Image/pinguino.png'),
                onPressed: (){
                  giro.reset();
                  giro.forward();
                },
              )),
            )
          ],
        ),
        backgroundColor: Color(0xff1e75a9),
        body: Padding(
          padding: EdgeInsets.only(top: 70, right: 30, left: 30),
          // EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    //decoration: BoxDecoration(
                      //color: Colors.blue,
                      // borderRadius: BorderRadius.all(Radius.circular(32))
                    //),
                    height: 200.0,
                    child: Image.asset('Image/pinguino.png'),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                // TextField(
                //   keyboardType: TextInputType.name,
                //   textAlign: TextAlign.center,
                //   onChanged: (value) {
                //     //Do something with the user input.
                //     nombre = value;
                //   },
                //   decoration: kTextFieldDecoration.copyWith(
                //       hintText: 'Escriba su nombre de usuario',
                //     prefixIcon: Icon(Icons.person),
                //   ),
                // ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: //kTextFieldDecoration.copyWith(
                      //hintText: 'Ingrese su correo electrónico'),
                  kTextFieldCorreo.copyWith(
                    errorText:  _displayNameValid ? null : 'No es un correo válido'
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  //textAlign: TextAlign.center,
                  decoration: //kTextFieldDecoration.copyWith(
                      // hintText: 'Ingrese su contraseña',
                      // prefixIcon: Icon(Icons.lock_outline, color: Colors.grey)
                  kTextFieldPassword.copyWith(
                    errorText: _displayNameValid ? null : 'No es una contraseña válida'
                  ),
                ),


                SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Material(
                    elevation: 10.0,
                    color: Color(0xff50c5b6),
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      //minWidth: 200.0,
                      //height: 20.0,
                      //padding: EdgeInsets.only(top: 0.0),
                      child: Text(
                        'Registrar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                         print("Se registró" + email);
                         FirebaseFirestore _firestore = FirebaseFirestore.instance;
                        try {
                          //NewUser es result

                          final UserCredential newUser =
                          await _auth.createUserWithEmailAndPassword(
                               email: email, password: password);
                          User? user = newUser.user;
                          // await FirebaseFirestore.instance.collection('users')
                          //     .doc(user?.uid).setData({ 'username': _username});
                          // ignore: unnecessary_null_comparison
                          if (newUser != null) {
                            Navigator.pushNamed(context, Home.id);
                            print("Cuenta creada exitosamente");

                            await _firestore.collection('users').doc(_auth.currentUser?.uid).set(
                                {
                                  "Nombre": loggedInUser?.displayName.toString(),
                                  "email": email,
                                  "status": "No disponible",
                                });
                          }
                          submit();
                          // ignore: unnecessary_null_comparison
                          setState(() {
                            showSpinner = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      color: Colors.white,
                      indent: 20,
                      endIndent: 20,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
               Container(
                child: _buildBody(),
              ),
  //Fila de botones de registro
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     SignInButton(Buttons.Facebook,
                    //         mini: true, onPressed: () {}),
                    //     SignInButton(Buttons.GitHub,
                    //         mini: true, onPressed: () {}),
                    //     SignInButton(Buttons.Microsoft,
                    //         mini: true, onPressed: () {})
                    //   ],
                    // ),
                  ],
                ),

                // RoundedButton(title: 'Registrar', colour: Colors.lightBlueAccent,
                //   onPressed: ()async{
                //   setState(() {
                //     showSpinner = true;
                //   });
                //   // print(email);
                //   // print(password);
                //     try {
                //       final newUser = await _auth.createUserWithEmailAndPassword(
                //           email: email, password: password);
                //       if(newUser != null){
                //         Navigator.pushNamed(context, ChatScreen.id);
                //       }
                //
                //       setState(() {
                //         showSpinner = false;
                //       });
                //     }
                //     catch(e){
                //       print(e);
                //     }
                // }
                // ,),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget _buildBody() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          //const Text("Registro exitoso."),
          Text(_contactText),
          ElevatedButton(
            child: const Text('Salir'),
            onPressed: () async =>   { _handleSignOut,
              _googleSignIn.disconnect(),
            },
          ),
          // ElevatedButton(
          //   child: const Text('Refrescar'),
          //   onPressed: () => _handleGetContact(user),
          // ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SignInButton(Buttons.GoogleDark,
              elevation: 10,
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                //side: BorderSide(color: Colors.black),
              ),
              text: 'Continúa con Google', onPressed: _handleSignIn,
          // ElevatedButton(
          //   child: const Text('SIGN IN'),
          //   onPressed: _handleSignIn,
          // ),
          ),
        ],
      );

    }


  }


  Future<User> getUser() async{
    return  _auth.currentUser!;
  }

   void submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Bienvenido $loggedInUser.email.toString()!"));
      _scaffoldKey.currentState!.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, loggedInUser!.email.toString());
      });
    }
     SnackBar snack = SnackBar(content: Text('Bienvenido $loggedInUser.email'));
     // _scaffoldkey.currentState!.showSnackBar(snack);
     ScaffoldMessenger.of(context).showSnackBar(snack);
   }

}




// void _showButtonPressDialog(BuildContext context, String provider) {
//   Scaffold.of(context).showSnackBar(SnackBar(
//     content: Text('$provider Button Pressed!'),
//     backgroundColor: Colors.black26,
//     duration: Duration(milliseconds: 400),
//   ));
// }





