import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/convert.dart';
import 'CRUD.dart';

String userID;
String textId;
bool play = false;

FirebaseService firebaseService = new FirebaseService();

class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  @override
  void dispose() {
    super.dispose();
    firebaseService.stop();
  }

  //getting user id
  void retreiveUserID() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uid;
    try {
      if (firebaseAuth.currentUser() != null) {
        final FirebaseUser user = await firebaseAuth.currentUser();
        uid = user.uid.toString();
        setState(() {
          userID = uid.toString();
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //get all the Text
  Future getText() async {
    var firestore = Firestore.instance;
    QuerySnapshot data = await firestore.collection("$userID").getDocuments();
    return data.documents;
  }

  @override
  void initState() {
    super.initState();
    retreiveUserID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ConvertTts()));
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 15.0,
              color: Colors.white,
            ),
          ),
        elevation: 0.0,
        centerTitle: true,
        title:  Text(
            "Recent",
            style: TextStyle(
                fontFamily: "Montserrat Regular",
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),
          ),
        actions: [
          FlatButton
                 (
                     child:Icon(Icons.delete,size: 20.0,color: Colors.white,),
                     onPressed: () 
                     {
                       firebaseService.allDialog(context);
                     },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: FutureBuilder(
            future: getText(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 6.0, bottom: 10.0),
                        child: Card(
                          elevation: 5.0,
                          color: Color.fromRGBO(45, 45, 45, 1),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onLongPress: () {
                                setState(() {
                                  textId = snapshot.data[index].data['Id']
                                      .toString();
                                });
                                firebaseService.deleteDialog(context, textId);
                              },
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom:10.0),
                                  child: Container(
                                    height: 170.0,
                                    child: ListView(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10.0,
                                          ),
                                          child: Text(
                                            "${snapshot.data[index].data['Text'].toString()}",
                                            style: TextStyle(
                                                fontFamily: "Montserrat Regular",
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right:5.0,),
                                  child: InkWell
                                  (
                                    borderRadius: BorderRadius.circular(40.0),
                                    onTap: ()
                                    {
                                      firebaseService.speak(snapshot.data[index].data['Text'].toString());
                                    },
                                    child: Icon(Icons.volume_up,color: Colors.white,size:20.0) 
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
      floatingActionButton: new FloatingActionButton(
        elevation: 5.0,
        child: Icon(
          Icons.stop,
          size: 25.0,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(255, 128, 51, 1),
        onPressed: () {
          firebaseService.stop();
        },
      ),
    );
  }
}

