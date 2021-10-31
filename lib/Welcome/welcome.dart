import 'package:flutter/material.dart';
import 'package:pestcontroller/Welcome/welcome_background.dart';
import 'package:pestcontroller/Login/login.dart';
import 'package:pestcontroller/components/rounded_button.dart';
import 'package:pestcontroller/Signup/signup.dart';

class Welcome extends StatefulWidget {

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO",
                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.green,fontSize: 24 ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "PEST DETECTION CONTROL",
                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.green,fontSize: 24 ),
              ),
              SizedBox(height: size.height * 0.05),
              Image.asset(
                "assets/login.png", color: Colors.green[800],
                height: size.height * 0.30,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Login();
                      },
                    ),
                  );
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: Colors.green,
                textColor: Colors.black,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
