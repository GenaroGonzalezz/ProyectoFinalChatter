
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:chatternet/screens/login_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:chatternet/screens/registration_screen.dart';
//import 'package:chatternet/Components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'Welcome Screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //late AnimationController controller; //Controla animaciones
  //Animation animation;
  @override
  void initState() {
    super.initState(); //Inicializador
    //controller = AnimationController(
      //duration: const Duration(seconds: 5),
     // vsync: this,
      //upperBound: 100.0,
    //);
    //animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    //controller.forward();
    // controller.addListener(() {
    //   setState(() { //Permite que la pantalla cambie al ser un stateful widget
    //     print(controller.value);
    //     print(animation.value);
    //   });
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e75a9), //.withOpacity(controller.value),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: ZoomIn(
                    animate: true,
                    duration: Duration(milliseconds: 1300),
                    child: Material(
                      elevation: 90,
                      child: Container(

                          child: Image.asset('Image/pinguino.png'),
                          height: 120 //controller.value,
                      ),
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
                const Text(
                  'Chatternoot',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),


            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: BounceInDown(
                  duration: Duration(milliseconds: 1100),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () =>
                      {Navigator.pushNamed(context, LoginScreen.id)},
                      //minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        "Iniciar sesion",
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: BounceInUp(
                  duration: Duration(milliseconds: 1500),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () =>
                      {Navigator.pushNamed(context, RegistrationScreen.id)},
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        "Registrar",
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
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
