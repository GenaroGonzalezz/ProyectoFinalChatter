
import 'package:chatternet/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:chatternet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Configuracion extends StatefulWidget {
  static const id = 'configuracion';

  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool showPassword = false;

  bool isLoading = false;
  bool _displayNameValid = true;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController _usernameController = TextEditingController();
User? user;
  @override
  void initState() {
    super.initState();
    getUser();
  }
  getUser() async {
    setState(() {
      isLoading = true;
    });
    // DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    // user = User.fromDocument(doc);
    // displayNameController.text = user.displayName;
    // bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: NewGradientAppBar(
        title: Text("Editar Perfil"),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.1,
              0.6,
            ],
            colors: [
              Color(0xff1b545c),
              Color(0xff1e5e68)
              //Color(0xff226974)
            ]
        ),
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Image.asset("Image/pinguino.png"),
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: (){FocusScope.of(context).unfocus();},
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Color(0xFFff7b00),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2, blurRadius: 10.0, color: Colors.black.withOpacity(0.1), offset: Offset(0, 10),
                          ),
                        ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://www.uic.mx/posgrados/files/2018/05/default-user.png"),
                    )
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Material(
                          child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Color(0xFFff7b00),
                          ),
                            color: Color(0xFFff7b00),
                      ),
                            child: IconButton(
                              padding: EdgeInsets.only(bottom: 0),
                              color: Colors.white,
                              onPressed: (){}, icon: Icon(Icons.edit),
                            ),
                    ),
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Nombre:',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: loggedInUser.displayName == null ? 'Agrega tu nombre' : loggedInUser.displayName,
                  hintStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                enabled: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: 'Correo electrónico',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: loggedInUser.email,
                    hintStyle: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                ),
              ),
              SizedBox(height: 25),
              buildTextField("Contraseña", '******', true),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: (){},child: Text("Cancelar", style: TextStyle(fontSize: 14, letterSpacing: 2.2, color: Colors.black),),

                  ),
                  RaisedButton(onPressed: () {
                    print('Nombre: ${_usernameController.text}');
                    // await loggedInUser.updateProfile(displayName: _usernameController.text);
                    setState(() {
                      updateProfile();
                    });
                    },
                    color: Color(0xFF1e75a9),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  child: Text("Guardar", style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.white,
                  ),
                  ),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField buildTextField(String labeltext, String placeholder, bool isPassText) {
    return TextField(
              obscureText: isPassText ? showPassword : false,
              decoration: InputDecoration(
                suffixIcon: isPassText ? IconButton(
                  onPressed: (){
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                ) : null,
                  contentPadding: EdgeInsets.only(bottom: 3),
                  labelText: 'Contraseña',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: '******',
                  hintStyle: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  enabled: false,
              ),
            );
  }
  void updateProfile() {
    setState(() {
      loggedInUser.updateProfile(displayName: _usernameController.text);

      _usernameController.text
          .trim()
          .length < 3 ||
          _usernameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;

      loggedInUser.updateProfile(displayName: _usernameController.text);
    });
     if (_displayNameValid) {
    //   usersRef.document(widget.currentUserId).updateData({
    //     "displayName": _usernameController.text,
    //   });

      SnackBar snack = SnackBar(content: Text('Perfil Actualizado'));
      // _scaffoldkey.currentState!.showSnackBar(snack);
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }
}
