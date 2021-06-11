
import 'dart:math';

import 'package:chatternet/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';
import 'configuracion.dart';
import 'package:animate_do/animate_do.dart';
import 'home.dart';
//import 'package:chatternet/constants.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'welcome_screen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class Acerca extends StatefulWidget {
  static const id = 'acerca';

  @override
  _AcercaState createState() => _AcercaState();
}
class Saludos extends StatefulWidget {

  @override
  _SaludosState createState() => _SaludosState();
}

class _SaludosState extends State<Saludos> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 20,
      title: Text('Notificaciones'),
      content:
      Text("¿Desea recibir notificaciones? Serán muy pocas de verdad :)"),
      actions: [
        TextButton(
            child: Text("Aceptar"),
            //textColor: Colors.blue,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
            child: Text("Cancelar"),
            //textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}


late AnimationController giro;
class _AcercaState extends State<Acerca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff226974),
        elevation: 60,
        title: Text("Acerca de Nosotros"),
        actions: [
          Flexible(
            child: Spin(
              animate: true,
              controller: (controller) => giro = controller,
              child: Hero(
                tag: 'logo',
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    padding: EdgeInsets.all(8),
                      icon: Image.asset('Image/pinguino.png'),
                      onPressed: () {
                          giro.reset();
                          giro.forward();

                        //Implement logout functionality
                        //_auth.signOut();
                        //Navigator.pop(context);
                        //messagesStream();
                      }
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 25, left: 25, bottom: 10),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Row(
                children: [
                  Integrante1(),
                  SizedBox(
                    height: 30,
                  ),
                  Integrante2(),
                  // SizedBox(
                  //   height: 50,
                  //   width: 50,
                  // ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Integrante3(),
                  SizedBox(
                    width: 30,
                  ),
                  Integrante4(),
                ],
              ),


              //const Animacion(),

              // Row(
              //   children: <Widget>[
              //     SlideInDown(
              //       child: ContenedorIntegrante(),
              //     ),
              //   ],
              // ),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.only(top: 10, right: 20),
              //         child: Card( // Tarjeta ==========================
              //           elevation: 20,
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //           color: Colors.blue ,
              //           shadowColor: Colors.black,
              //           child: Column(
              //             children: [
              //               Container(
              //                 child: Padding(
              //                   padding: EdgeInsets.all(20),
              //                   child: Flexible(
              //                     child: Text(
              //                       "González Sepúlveda Genaro Eugenio",
              //                       style: TextStyle(
              //                           color: Colors.lightGreenAccent
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ]
              // ),
              //Otra fila =========================
              // Container(
              //   padding: EdgeInsets.all(10),
              //   child: Card( // Tarjeta ==========================
              //     elevation: 20,
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //     color: Colors.blue ,
              //     shadowColor: Colors.black,
              //     child: Column(
              //       children: [
              //         Container(
              //           child: Padding(
              //             padding: EdgeInsets.all(20),
              //             child: Text(
              //               "Integrante 1",
              //               style: TextStyle(
              //                   color: Colors.lightGreenAccent
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              InformacionEquipo(),
            ],
            ),
          ),
        ),
      ),
    );
  }

}

class ContenedorIntegrante extends StatefulWidget {

  @override
  _ContenedorIntegranteState createState() => _ContenedorIntegranteState();
}

class _ContenedorIntegranteState extends State<ContenedorIntegrante> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // alignment: Alignment.bottomLeft,
      // padding: EdgeInsets.only(top: 10, left: 20),
      child: AnimatedContainer(// Tarjeta ==========================
        duration: Duration(seconds: 2),
        width: 270,
        height: 270,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        // elevation: 20,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //color: Colors.blueAccent ,
        // shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(20),

                        ),
                      );
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Integrante 1",
                      style: TextStyle(
                          color: Colors.lightGreenAccent
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Animacion extends StatefulWidget {
  const Animacion({Key? key}) : super(key: key);

  @override
  State<Animacion> createState() => _EstadoAnimacion();
}


class _EstadoAnimacion extends State<Animacion> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;

        });
      },
      child: Row(
        children: <Widget>[
           AnimatedContainer(

            width: selected ? 200.0 : 100.0,
            height: selected ? 100.0 : 200.0,
            color: selected ? Colors.blueAccent : Colors.blueAccent,
            alignment:
            selected ? Alignment.center : AlignmentDirectional.topCenter,
            duration: const Duration(milliseconds: 600),
            curve: Curves.linear,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Gastelum Coronado Victor Manuel",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightGreenAccent,
                  ),
                ),
                Flexible(child: Image.asset("Image/pinguino.png")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Integrante1 extends StatefulWidget {

  @override
  _Integrante1State createState() => _Integrante1State();
}

class _Integrante1State extends State<Integrante1> {
  @override
  Widget build(BuildContext context) {
    return Align(
      //alignment: Alignment.topLeft,
    child: BounceInDown(
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          width: 150,
          height: 200,
          curve: Curves.bounceOut,
          decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: Color(0xFFff7b00),
            ),
            color: Color(0xFF1e75a9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      border: new Border.all(color: Color(0xFFff7b00), width: 4.0)
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://lh3.googleusercontent.com/a-/AOh14Gj_MHo2sPDJdSSToPDQ5KAEF05_PfU1geP1kIPT=s32-c"),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Gastelum Coronado \n Victor Manuel \n 16212008",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ),
      ),
    ),
      );
  }
}


class Integrante2 extends StatefulWidget {

  @override
  _Integrante2State createState() => _Integrante2State();
}

class _Integrante2State extends State<Integrante2> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.topRight,
        child: Align(alignment: Alignment.topRight,
          child: SlideInRight(
            child: Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                width: 150,
                height: 200,
                curve: Curves.bounceOut,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 5,
                    color: Color(0xFFff7b00),
                  ),
                    color: Color(0xFF1e75a9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            shape: BoxShape.circle,
                            border: new Border.all(color: Color(0xFFff7b00), width: 4.0)

                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("https://lh3.google.com/u/0/ogw/ADGmqu8gCuPSZTpxAjbnJAMUIXq0wshE6vNm7c2IkrOC=s32-c-mo"),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Gonzalez Sepulveda \n Genaro Eugenio \n 16212017",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class Integrante3 extends StatefulWidget {


  @override
  _Integrante3State createState() => _Integrante3State();
}

class _Integrante3State extends State<Integrante3> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SlideInLeft(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            width: 150,
            height: 200,
            curve: Curves.bounceOut,
            decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color: Color(0xFFff7b00),
              ),
              color: Color(0xFF1e75a9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      shape: BoxShape.circle,
                      border: new Border.all(color: Color(0xFFff7b00), width: 4.0)

                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://lh3.googleusercontent.com/a-/AOh14GiBegUK-0_URSMggGRbqy5YIEskpC2OYdPbJkbr=s32-c"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Loera Rodriguez \n Jose Manuel \n 16212027",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Integrante4 extends StatefulWidget {


  @override
  _Integrante4State createState() => _Integrante4State();
}

class _Integrante4State extends State<Integrante4> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.bottomRight,
        child: SlideInUp(
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 10,
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              width: 150,
              height: 200,
              curve: Curves.bounceOut,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Color(0xffff7b00),
                ),
                  color: Color(0xFF1e75a9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: new Border.all(color: Color(0xFFff7b00), width: 4.0)

                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("https://lh3.googleusercontent.com/a-/AOh14GiHoyCXIL_HiOop0U3K4Jwf6TWq6zXPLvthGUEH7g=s32-c"),
                        ),
                      ),
                       SizedBox(
                         height: 5,
                       ),
                       Text(
                        "Ortiz Vasquez \n Luis Fernando \n 16212059",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                           fontSize: 15,
                         ),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InformacionEquipo extends StatefulWidget {

  @override
  _InformacionEquipoState createState() => _InformacionEquipoState();
}

class _InformacionEquipoState extends State<InformacionEquipo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( top: 10),
      child: Align(alignment: Alignment.bottomRight,
        child: SlideInUp(
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 10,
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              width: 400,
              height: 200,
              curve: Curves.bounceOut,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Color(0xffff7b00),
                ),
                color: Color(0xff1e75a9),//Color.fromRGBO(80, 197, 182, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Diseño de interfaces UI/UX \n Febrero-Junio 2021 \n Proyecto Final: Chatternoot para mensajería instantánea",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


