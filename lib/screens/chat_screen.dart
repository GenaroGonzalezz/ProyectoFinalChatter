
import 'package:animate_do/animate_do.dart';
import 'package:chatternet/screens/home.dart';

//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatternet/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'about_us.dart';
import 'registration_screen.dart';
//import 'home.dart';
import 'welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'configuracion.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';


class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;
User loggedInUser = FirebaseAuth.instance.currentUser!;

GoogleSignIn googleSignIn = new GoogleSignIn();
User? _user;


GoogleSignIn _googleSignIn = GoogleSignIn(

);

//User loggedInUser;
String messageText = "";
final fieldText = TextEditingController();

late AnimationController giro;

class _ChatScreenState extends State<ChatScreen> {
//===========================Imagen===================================
  //late var image;
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGaleria() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null){
        _image = File(pickedImage.path);
      }else{
        print("No imagen seleccionada");
      }
    });
  }

  bool imageSelected = false;
  //================================= Imagen ==========


  final messageTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    //Verifica si hay un usuario que haya iniciado sesion
    try {
      loggedInUser = _auth.currentUser!;
      final user = _auth.currentUser;
      // ignore: unnecessary_null_comparison
      if (loggedInUser.emailVerified != null) {
        //await currentUser.sendEmailVerification();
        loggedInUser = user!;
        //print(currentUser.email);
      } else {
        // currentUser = user;
        // print(currentUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  //Metodo para obtener mensajes del cloud firestore
  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs){
  //     print(message.data());
  //   }
  // }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data().cast());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: NewGradientAppBar(
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
        title: Text(
            loggedInUser.displayName == null ? loggedInUser.email.toString() : loggedInUser.displayName.toString()),
        //backgroundColor: Color(0xff226974),
        //     backgroundColor: Colors.black
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          )
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
                    onPressed: () {
                      //Implement logout functionality
                      //_auth.signOut();
                      //Navigator.pop(context);
                      giro.reset();
                      giro.forward();
                      //messagesStream();
                    }),
              ),
            ),
          ),
        ],
        //title: Text('⚡️Chat'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       stops: [
        //
        //         0.6,
        //         0.9,
        //       ],
        //       colors: [
        //
        //         Colors.cyan,
        //         Colors.cyanAccent,
        //       ],
        //     )
        // ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            MessagesStream(),
            Container(
              decoration:
              kMessageContainerDecoration,

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Material(
                  //   child: _image == null
                  //       ? Text(' - ')
                  //       : Image.file(_image!),
                  // ),
                  //========Boton para agregar imagen==============
                  // Padding(
                  //   padding: EdgeInsets.all(1),
                  //   child: FloatingActionButton(
                  //     elevation: 10,
                  //     onPressed: () async => await getImageFromGaleria(),
                  //     tooltip: 'Pick Image',
                  //     child: Icon(Icons.add_a_photo),
                  //   ),
                  // ),
                  // ==============================================
                  //CuadroTexto(),
        Expanded(
          child: TextField(
            controller:
            messageTextController, //Controla el texto del campo
            onChanged: (value) {
              messageText = value;
              //Do something with the user input.
            },
            decoration: kMessageTextFieldDecoration,
          ),
        ),
        //====================Espacio para contener imagen
        // Flexible(
        //   child: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: 200,
        //     child: Center(
        //       child: _image == null ? Text("") : Image.file(_image!),
        //     ),
        //   ),
        // ),
                  //=========================================
                  // TextButton(
                  //   onPressed: () {
                  //     messageTextController.clear();
                  //     _firestore.collection('messages').add({
                  //       'text': messageText,
                  //       'sender': loggedInUser.email,
                  //     });
                  //     //Implement send functionality.
                  //   },
                  //   child: Text(
                  //     'Send',
                  //     style: kSendButtonTextStyle,
                  //   ),
                  // ),
                  Material(
                    elevation: 10,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    child: IconButton(
                        icon: Icon(
                          Icons.double_arrow_sharp,
                          semanticLabel: 'Enviar',
                          size: 40,
                          color: Colors.lightBlue,
                        ),
                        padding: EdgeInsets.only( bottom: 20, top: 5, left: 5, right: 5),
                        onPressed: () async {
                          Map<String, dynamic> messages = {
                            "sendby": loggedInUser.displayName != null ? _auth.currentUser?.displayName : loggedInUser.email.toString(),
                            "message": messageText,
                            "time": FieldValue.serverTimestamp(),
                          };
                            messageTextController.clear();
                            _firestore.collection('messages').add({
                              'text': messageText,
                              'sender': loggedInUser.email,
                              'timestamp': FieldValue.serverTimestamp(),
                              //'image': _image,
                            });
                            imageSelected = false;
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // final _picker = ImagePicker();
  // Future _seleccionar() async {
  //   PickedFile image = (await _picker.getImage(source: ImageSource.gallery))!;
  // }

}




class MessagesStream extends StatelessWidget {
  //const MessagesStream({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //Widget para desplegar un stream de datos
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots(), //Los datos seran la coleccion de mensajes en FS
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        // final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          // final messageSenderName = message['namesender'];

          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {}
          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              //senderName: messageSenderName,
              isMe: currentUser == messageSender);
          messageBubbles.add(messageBubble);
          //Inicio de sesion
          // Future<UserCredential> _signInWithGoogle() async {
          //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          //
          //   GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
          //   GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
          //
          //   final credential = GoogleAuthProvider.credential(
          //     accessToken: googleAuth.accessToken,
          //     idToken: googleAuth.idToken,
          //   );
          //   return await FirebaseAuth.instance.signInWithCredential(credential);

          //Fin de autenticacion
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
          //final messages = snapshot.data!.docs.reversed;
          //List<MessageBubbleGoogle> messageBubblesGoogle = [];
   //Inicio de sesion
   //  Future<UserCredential> _signInWithGoogle() async {
   //    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
   //
   //    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
   //    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
   //
   //    final credential = GoogleAuthProvider.credential(
   //      accessToken: googleAuth.accessToken,
   //      idToken: googleAuth.idToken,
   //    );
   //    return await FirebaseAuth.instance.signInWithCredential(credential);

      //Fin de autenticacion
    // }
    //       return Expanded(
    //         child: ListView(
    //           reverse: true,
    //           padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    //           children: messageBubblesGoogle,
    //         ),
    //       );

      //  },

class MessageBubble extends StatelessWidget {
  const MessageBubble({ required this.sender,  required this.text,  required this.isMe});
  //const MessageBubble({Key key}) : super(key: key);
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
           Padding(
             padding: EdgeInsets.only(bottom: 5),
             child: Text(
               sender,
               style: TextStyle(color: Colors.grey, fontSize: 12.0),
               textAlign: TextAlign.right,
               
             ),
           ),
          
          Row(
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              //Para que se vea a la izquierda el otro usuario
              if (!isMe)
                Material(
                  elevation: 10.0,
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 9),
                    child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: loggedInUser.photoURL == null ? (Text(sender[0].toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )) : (ClipOval(
                          child: Material(
                            child: Image.network(
                              loggedInUser.photoURL!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ))
                    ),
                  ),
                ),
              //Mensaje
              Flexible(
                child: Material(
                  elevation: 10.0,
                  borderRadius: isMe
                      ? BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(-10))
                      : BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              //Para que se vea a la derecha el usuario actual
              if (isMe)
                Material(
                  elevation: 10.0,
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 9),
                    child: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          sender[0].toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ),
                ),
            ],
          ),
          //Text(//timestamp.toString()),
          //Text(sender, style: TextStyle(color: Colors.grey, fontSize: 12.0), textAlign: TextAlign.right,),
        ],
      ),
    );
  }
}

//Pantalla de chat para usuarios registrados con Google porque la neta no me da chance de refactorizar xD
// class MessageBubbleGoogle extends StatelessWidget {
//   const MessageBubbleGoogle({ required this.sender,  required this.text,  required this.isMe});
//   //const MessageBubble({Key key}) : super(key: key);
//   final String sender;
//   final String text;
//   final bool isMe;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//       child: Column(
//         mainAxisAlignment:
//         isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment:
//         isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             sender,
//             style: TextStyle(color: Colors.grey, fontSize: 12.0),
//             textAlign: TextAlign.right,
//           ),
//           Row(
//             mainAxisAlignment:
//             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//             crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//             children: <Widget>[
//               //Para que se vea a la izquierda el otro usuario
//               if (!isMe)
//                 Material(
//                   elevation: 10.0,
//                   shape: CircleBorder(
//                     side: BorderSide.none,
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10, right: 9),
//                     child: CircleAvatar(
//                         backgroundColor: Colors.blueAccent,
//                         child: Text(
//                           sender[0],
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         )),
//                   ),
//                 ),
//               //Mensaje
//               Flexible(
//                 child: Material(
//                   elevation: 10.0,
//                   borderRadius: isMe
//                       ? BorderRadius.only(
//                       topLeft: Radius.circular(10.0),
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                       topRight: Radius.circular(-10))
//                       : BorderRadius.only(
//                       topRight: Radius.circular(10.0),
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10)),
//                   color: isMe ? Colors.lightBlueAccent : Colors.white,
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         color: isMe ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               //Para que se vea a la derecha el usuario actual
//               if (isMe)
//                 Material(
//                   elevation: 10.0,
//                   shape: CircleBorder(
//                     side: BorderSide.none,
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 10, right: 9),
//                     child: CircleAvatar(
//                         backgroundColor: Colors.blueAccent,
//                         child: Text(
//                           sender[0],
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         )),
//                   ),
//                 ),
//             ],
//           ),
//
//           //Text(sender, style: TextStyle(color: Colors.grey, fontSize: 12.0), textAlign: TextAlign.right,),
//         ],
//       ),
//     );
//   }
// }
//
// mixin FirebaseUser {
// }
class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 90,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: <Widget>[
                  //                  Container(
                  //                     padding: EdgeInsets.only(top: 50),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(30),
                  //                       color: Colors.white,
                  //                         image: new DecorationImage(
                  //                           fit: BoxFit.cover,
                  //                           image: NetworkImage('https://2.bp.blogspot.com/-J5dtIRU_dqo/WZqgWuk5r3I/AAAAAAAAAAY/9CCoDfgsfyEPfAJURbzewU5wAiEZ3mIgQCLcBGAs/s1600/Pingu%25CC%2588ino2.jpg'),
                  //                           ),
                  //                         // image: CircleAvatar(
                  //                         //   child: ,
                  //
                  //                          // CircleAvatar(child: Text(loggedInUser.email![0]),
                  //                       //   image: GoogleUserCircleAvatar(identity: RegistrationScreen),
                  //                                               //  CircleAvatar(child: Text(loggedInUser.email[0]),
                  //                       //                       //
                  //                          //fit: BoxFit.cover,
                  //
                  //                       boxShadow: [
                  //                         BoxShadow(color: Colors.green, spreadRadius: 4),
                  //                       ],
                  //                     ),
                  //                     height: 50,
                  //                     width: 50,
                  //                   )
                  Container(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      // foregroundColor: Colors.blueAccent,
                      child: loggedInUser.displayName == null ? Text(loggedInUser.email![0].toUpperCase()) : Text(loggedInUser.displayName![0].toUpperCase()),
                    ),
                  ),
                  Text(
                    loggedInUser.displayName == null ? loggedInUser.email.toString() : loggedInUser.displayName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff226974),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1),
                  bottomRight: Radius.circular(15)),
            ),
          ),
          Container(
            height: 30,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () => {Navigator.pushNamed(context, Home.id)},
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () => {Navigator.pushNamed(context, Configuracion.id)},
          ),

          ListTile(
            leading: Icon(Icons.people),
            title: Text('Acerca de Nosotros'),
            onTap: () => {Navigator.pushNamed(context, Acerca.id)},
          ),

          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Cerrar sesión'),
              onTap: () async => {
                await _auth.signOut(),
                Navigator.pushNamed(context, WelcomeScreen.id)
              }),
        ],

      ),
    );
  }

}




void clearText() {
  fieldText.clear();
}
