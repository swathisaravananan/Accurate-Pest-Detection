//@dart=2.9
import 'package:flutter/material.dart';
import 'package:pestcontroller/graph/Pestcounthomepage.dart';
import 'package:pestcontroller/graph/PestvsMonthhomepage.dart';
import 'package:pestcontroller/components/rounded_button.dart';

class GraphHomePage extends StatefulWidget {

  @override
  _GraphHomePageState createState() => _GraphHomePageState();
}

class _GraphHomePageState extends State<GraphHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        //SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                
                text: "Pest VS Count",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PestcountHomePage()));
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Pest VS Month",
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PestvsMonthHomePage()));
                },
              ), 
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
    );
  }
}
