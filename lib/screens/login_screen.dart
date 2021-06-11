import 'dart:async';
import 'dart:convert' show json;
import 'package:animate_do/animate_do.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import "package:http/http.dart" as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:chatternet/constants.dart';
import 'package:flutter/material.dart';
import 'home.dart';
//import 'package:chatternet/Components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'chat_screen.dart';
 import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginScreen extends StatefulWidget {
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  User? loggedInUser = FirebaseAuth.instance.currentUser;

  bool? isAccountGoogle;

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  final _text = TextEditingController();
  bool _validate = false;
  //AuthService authService = new AuthService();
  final formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late Firebase auth;
  bool isUserSignedIn = false;

  bool showSpinner = false;
   late String email;
   late String password;
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  //Sobrecarga para metodos de inicio de sesion
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        // _contactText = "People API gave a ${response.statusCode} "
        //     "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }
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
    bool isSignedIn = await _googleSignIn.isSignedIn();
      await _googleSignIn.signIn();

      MaterialPageRoute(
          builder: (context) =>
              ChatScreen());
  }
  Future<void> _handleSignOut() => _googleSignIn.disconnect();
  late AnimationController giro;
  //Sobrecarga de Widget para diseño de pantalla
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(FocusNode());}, //Si tocas cualquier otro lugar se esconde el teclado c:
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inicia Sesión"),
          //backgroundColor: Color(0xff1a888b),
          backgroundColor: Color(0xff226974),
          //elevation: 40,
          toolbarHeight: 55,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          leading: null,
          actions: [
            Spin(
              animate: true,
              controller: (controller) => giro = controller,
              child: Hero(
                  tag: 'logo',
                  child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Image.asset('Image/pinguino.png'),
                  onPressed: (){
                    giro.reset();
                    giro.forward();
                  },
                ),
              )),
            )
          ],
        ),
        backgroundColor: Color(0xff1e75a9),
        body: Padding(
          padding: EdgeInsets.only(top: 70, right: 30, left: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 200.0,
                  child: Image.asset('Image/pinguino.png'),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  validator: (value) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!)
                        ? null
                        : "Please Enter Correct Email";
                  },
                  controller: emailEditingController,
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
                  kTextFieldCorreo,
                ),
                SizedBox(
                  height: 8.0,
                ),
                //Contraseña
                TextFormField(
                  validator: (val) {
                    return val!.length > 6
                        ? null
                        : "Enter Password 6+ characters";
                  },
                  controller: passwordEditingController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: //kTextFieldDecoration.copyWith(
                  kTextFieldPassword,
                  // InputDecoration(
                  //     hintText: 'Ingrese su contraseña',
                  //     fillColor: Colors.white12,
                  //     hoverColor: Colors.white,
                  //     enabled: true,
                  //     filled: true,
                  //
                  //     prefixIcon: Icon(Icons.lock_outline, color: Colors.white70),
                  //     hintStyle: TextStyle(color: Colors.white),
                  //   contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(32),),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.black12, width: 1.0),
                  //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  //   ),
                  //   focusedBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.white, width: 2.0),
                  //     borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  //   )
                  // ),

                ),

            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Material(
                elevation: 30.0,
                color: Color(0xff50c5b6),
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  //minWidth: 200.0,
                  //height: 42.0,
                  //padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Iniciar sesion',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                      print("Inicio sesion" + email);
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      // ignore: unnecessary_null_comparison
                      if (user != null) {
                        Navigator.pushNamed(context, Home.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                      //Navigator.pushNamed(context, LoginScreen.id);
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
                SizedBox(
                  height: 5.0,
                ),

                SizedBox(
                  height: 5.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: _buildBody(),
                    ),
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
                )
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
          //const Text("Inicio de sesión exitoso."),
          Text(_contactText),
          ElevatedButton(
            child: const Text('Cerrar sesion'),
            onPressed: _handleSignOut,
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
                borderRadius: BorderRadius.circular(20),
                //side: BorderSide(color: Colors.black),
              ),
              text: 'Continúa con Google', onPressed: () async
              {
                _handleSignIn();

              }),

          // ElevatedButton(
          //   child: const Text('SIGN IN'),
          //   onPressed: _handleSignIn,
          // ),
        ],
      );
    }
  }
}
