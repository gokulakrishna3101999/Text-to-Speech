import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/CRUD.dart';
import 'package:tts/login.dart';

FirebaseService firebaseService = new FirebaseService();


//greeting function
  greeting()
  {
    final currentTime = DateTime.now();
    var day = currentTime.day,month=currentTime.month,year=currentTime.year;
    print(currentTime);
    print(day);
    print(year);
    print(month);
    if(currentTime.hour>24 && currentTime.hour<12)
    {
       print("Good Morning");
       Fluttertoast.showToast(msg:"Good Morning");
       firebaseService.speak("Good Morning"); 
    }
    else if(currentTime.hour>=12 && currentTime.hour<16)
    {
       print("Good Afternoon");
       Fluttertoast.showToast(msg:"Good Afternoon");
       firebaseService.speak("Good Afternoon"); 
    }
    else if(currentTime.hour>=16 && currentTime.hour<=24)
    {
       print("Good Evening");
       Fluttertoast.showToast(msg:"Good Evening");
       firebaseService.speak("Good Evening"); 
    }
  }

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    theme: new ThemeData
    (
      primarySwatch: Colors.grey,
      scaffoldBackgroundColor: Color.fromRGBO(40,40,40,1),
      primaryColor: Color.fromRGBO(40,40,40,1),
      dialogBackgroundColor: Colors.orange,
      dialogTheme: DialogTheme(backgroundColor: Colors.orange),
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
  }

  @override
  void initState() {
    super.initState();
    greeting();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container
      (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                 child: CircleAvatar
                             (
                               maxRadius: 50.0,
                               minRadius: 40.0,
                               backgroundColor: Color.fromRGBO(40,40,40,1),
                               child: Image.asset('images/logo.png',fit: BoxFit.cover,)
                             ),
               ),
               Padding(
            padding: const EdgeInsets.only(left:138.0,right: 138.0,top: 10.0),
            child: Text("Hello!",textAlign: TextAlign.center,style: TextStyle
            (
              fontFamily: "Montserrat Bold",fontWeight: FontWeight.w700,fontSize: 24,color:Color(0xffffffff),  
            ),
            ),
          ),
          ],
        ),
           
         
      )
    );
  }
}
