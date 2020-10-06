import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tts/generated_audio.dart';
import 'convert.dart';
import 'CRUD.dart';

FirebaseService fireBaseService = new FirebaseService(); 

class TextToSpeech extends StatefulWidget {
  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {

  @override
  void dispose() {
    super.dispose();
    fireBaseService.stop();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 0.0,
        actions: [
          FlatButton
                   (
                     onPressed: ()
                     {
                       fireBaseService.showAlertDialog(context);
                     }, 
                     child: Image.asset('images/dots.png',height: 17.0,),
                   ),
             ],      
      ),
      body: ListView
      (
        children: <Widget>
        [
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
              child: Center
              (
                child: Text("Text to Speech",style:TextStyle(color: Colors.white,fontSize:17.0,fontWeight:FontWeight.bold,fontFamily:"Montserrat Regular")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:20.0),
              child: Center
              (
                child: InkWell
                (
                  borderRadius:BorderRadius.circular(32.00),
                  onTap: ()
                  {
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ConvertTts()));
                  },
                  child: new Container
                  (
                    height: 183.00,
                    width: 306.00,
                    child: Center
                    (
                      child: Container
                      (
                        height: 110.0,
                        width: 170,
                        child:Image.asset('images/icon1.png')
                      ),
                    ),
                    decoration: BoxDecoration
                    (
                      color: Color(0xffff9156),borderRadius: BorderRadius.circular(33.00),
                      gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromRGBO(255,148,90,1),Color.fromRGBO(255,128,51,1)]),
                    ), 
                  ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:25.0),
              child: Center
              (
                child: InkWell
                (
                  borderRadius:BorderRadius.circular(32.00),
                  onTap: ()
                  {
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GenerateAudio()));
                  },
                  child: new Container
                  (
                    height: 183.00,
                    width: 306.00,
                    child: Center
                    (
                      child: Container
                      (
                        height: 110.0,
                        width: 170,
                        child:Image.asset('images/icon2.png')
                      ),
                    ),
                    decoration: BoxDecoration
                    (
                      color: Color(0xff9a56ff),borderRadius: BorderRadius.circular(33.00),
                      gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromRGBO(187,151,255,1),Color.fromRGBO(122,94,233,1)]),
                    ), 
                  ),
              ),
            ),
          ),
        ],
      )
    );
  }
}