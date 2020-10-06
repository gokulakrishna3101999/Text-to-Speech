import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tts/TextToSpeech.dart';
import 'package:tts/recent.dart';
import 'lang.dart';
import 'CRUD.dart';

double space = 10.0;
bool visible = false;
TextEditingController convertTextController = new TextEditingController();
FirebaseService fireBaseService = new FirebaseService();
bool isplaying = false;
String imagePath = "images/Play.png";

class ConvertTts extends StatefulWidget {
  @override
  _ConvertTtsState createState() => _ConvertTtsState();
}

class _ConvertTtsState extends State<ConvertTts> {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    firebaseService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => TextToSpeech()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 15.0,
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              fireBaseService.showAlertDialog(context);
            },
            child: Image.asset(
              'images/dots.png',
              height: 17.0,
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
              child: TextFormField(
                maxLines: 17,
                controller: convertTextController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefix: Text(" "),
                  hintText: 'Enter your text here',
                  hintStyle: TextStyle(fontFamily: "Montserrat Regular"),
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  )),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      firebaseService.stop();
                      imagePath = "images/Stop.png";
                      space = 0.0;
                      visible = false;
                    });
                  } else if (value.isNotEmpty) {
                    setState(() {
                      space = 10.0;
                      imagePath = "images/Play.png";
                      visible = true;
                    });
                  }
                },
                validator: (val) {
                  if (val.isEmpty) {
                    return 'Please enter some text !';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.00),
                      onTap: () {
                        if (isplaying == false) {
                          setState(() {
                            imagePath = "images/Stop.png";
                            isplaying = true;
                            fireBaseService.speak(convertTextController.text);
                          });
                        } else {
                          setState(() {
                            imagePath = "images/Play.png";
                            isplaying = false;
                            firebaseService.stop();
                          });
                        }
                      },
                      child: Visibility(
                        visible: visible,
                        child: new Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                imagePath,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (visible == false)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.00),
                        onTap: () {
                          visible = false;
                          convertTextController.clear();
                        },
                        child: new Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "images/delete.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (visible == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15.00),
                        onTap: () {
                          setState(() {
                            visible = false;
                          });
                          convertTextController.clear();
                        },
                        child: new Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "images/delete.png",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15.00),
                    onTap: () {
                      convertTextController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Language()));
                    },
                    child: new Container(
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "images/lang.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 130.0, right: 130.0),
              child: RaisedButton(
                elevation: 1.0,
                hoverColor: Color.fromRGBO(40, 40, 40, 1),
                color: Colors.white,
                onPressed: () {
                  FormState formState = formKey.currentState;
                  if (formState.validate()) {
                    fireBaseService.speak(convertTextController.text);
                    fireBaseService.saveToDatabase(convertTextController.text);
                    setState(() {
                      imagePath = "images/Stop.png";
                      isplaying = true;
                      firebaseService.stop();
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                    child: Text(
                  "Speak !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Montserrat Regular", color: Colors.orange),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5.0),
              child: Center(
                child: InkWell(
                    onTap: () {
                      convertTextController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Recent()));
                    },
                    child: Text(
                      "Recent",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Montserrat Regular",
                          color: Colors.white),
                    )),
              ),
            ),
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(20.00),
                onTap: () {
                  convertTextController.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Recent()));
                },
                child: CircleAvatar(
                    maxRadius: 10.0,
                    minRadius: 10.0,
                    backgroundColor: Color.fromRGBO(40, 40, 40, 1),
                    child: Icon(Icons.arrow_drop_up,
                        size: 30.0, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20.0)
          ],
        ),
      ),
    );
  }
}

/*    appBar: AppBar
      (
        leading: Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: InkWell
                       (
                         borderRadius:BorderRadius.circular(40.00),
                         onTap: ()
                         {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TextToSpeech()));
                         },
                         child: CircleAvatar
                         (
                           maxRadius: 20.0,
                           minRadius: 20.0,
                           backgroundColor:Color.fromRGBO(40,40,40,1),
                           child: Icon(Icons.arrow_back_ios,size: 15.0,color: Colors.white,)
                         ),
                       ),
                   ),
        elevation: 0.0,
        centerTitle: true,
        title: Text("Text to Speech",style: TextStyle(fontFamily: "Montserrat Regular",color:Colors.white,fontWeight: FontWeight.bold),),
        actions: [
                Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: RawMaterialButton
                     (
                       onPressed: () 
                       {
                         fireBaseService.showAlertDialog(context);
                       },
                       elevation: 0.0,
                       fillColor: Color.fromRGBO(40,40,40,1),
                       child: Image.asset('images/dots.png',height: 17.0,),
                       padding: EdgeInsets.only(top:8.0,right: 0.0),
                       shape: CircleBorder(),
                      ),
                   ),
             ],      
      ), */
