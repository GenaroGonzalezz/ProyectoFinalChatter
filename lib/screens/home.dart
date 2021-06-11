
import 'package:animate_do/animate_do.dart';
import 'package:chatternet/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'about_us.dart';
import 'package:chatternet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'newChatScreen.dart';
// ignore: must_be_immutable

class Home extends StatefulWidget {
  static const id = 'home';


  @override
  _HomeState createState() => _HomeState();
}
FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
User loggedInUser = FirebaseAuth.instance.currentUser!;
final GoogleSignIn googleSignIn = new GoogleSignIn();


late AnimationController giro;
class _HomeState extends State<Home> {
  late Stream chatRooms;

  //===============================================================


  //======================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        //Navigator.pushNamed(context, ChatRoom.id);
        print("Yes");}, label: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: SideDrawer(),
      appBar: NewGradientAppBar(
        title: Text('Chatternoot'),
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
        //backgroundColor: Color(0xff226974),
        //toolbarHeight: 55,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        leading: null,

        actions: <Widget>[
          Spin(
            //duration: Duration(seconds: 2),
            animate: true,
            controller: (controller) => giro = controller,
            child: Hero(
              tag: 'logo',
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                    icon: Image.asset('Image/pinguino.png'),
                    // padding: EdgeInsets.all(8),
                    onPressed: () {
                      giro.reset();
                      giro.forward();
                      //Implement logout functionality
                      //_auth.signOut();
                      //Navigator.pop(context);
                      //messagesStream();
                    }),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xff1e75a9),
      body: Padding(
        padding: EdgeInsets.all(8),//EdgeInsets.only(top: 70, right: 30, left: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Chats(),
                  //TarjetaEquipo(),
                  //Conversacion(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PanelChat extends StatefulWidget {

  @override
  _PanelChatState createState() => _PanelChatState();
}

class _PanelChatState extends State<PanelChat> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Chats extends StatefulWidget {

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Padding( padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()));
         // Navigator.pushNamed(context, ChatScreen.id);
        },
        child: Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 55,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              //border: Border.all(color: Colors.blueAccent, width: 2),
              color: Color.fromRGBO(255, 255, 255, 10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     offset: Offset(6.0, 7.0), //(x,y)
              //     blurRadius: 6.0,
              //   ),
              // ],
            ),
            child: (
                Row(
                  children: [
                    Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(30), color: Colors.transparent,
                      child: CircleAvatar(
                      child: Text(loggedInUser.email![0].toUpperCase()),
                        //backgroundColor: Color.fromRGBO(, g, b, opacity),
                      ),
                    ),
                      //backgroundImage: ),
                    //loggedInUser == googleSignIn.isSignedIn() ? NetworkImage(loggedInUser.photoURL.toString() : NetworkImage(loggedInUser.photoURL.toString() : NetworkImage('http://assets.stickpng.com/images/585e4beacb11b227491c3399.png' : NetworkImage('http://assets.stickpng.com/images/585e4beacb11b227491c3399.png')
                      //backgroundImage: NetworkImage('http://assets.stickpng.com/images/585e4beacb11b227491c3399.png'),
                    //Icon(Icons.add),
                    Padding(padding: EdgeInsets.all(10)),
                    Material(
                      child: loggedInUser.displayName == null ?
                      (Text(loggedInUser.email.toString(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,),)
                      ):
                      (Text(loggedInUser.displayName.toString(), style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      )),

                    ),
                    //Flexible(child: Text(loggedInUser.displayName.toString())),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}

class TarjetaEquipo extends StatefulWidget {

  @override
  _TarjetaEquipoState createState() => _TarjetaEquipoState();
}

class _TarjetaEquipoState extends State<TarjetaEquipo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}

class Conversacion extends StatefulWidget {
  @override
  _ConversacionState createState() => _ConversacionState();
}

class _ConversacionState extends State<Conversacion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ButtonBar(
          children: [
            Icon(Icons.people),
            MaterialButton(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              color: Colors.blueAccent,
              onPressed: () =>
              {Navigator.pushNamed(context, Acerca.id)},
              minWidth: 200.0,
              height: 60.0,
              child: Text(
                "Acerca de nosotros",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _opciones extends StatefulWidget {


  @override
  __opcionesState createState() => __opcionesState();
}

class __opcionesState extends State<_opciones> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

