import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:tts/exportHistory.dart';
import 'package:tts/recent.dart';
import 'TextToSpeech.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'convert.dart';
import 'generated_audio.dart';
import 'login.dart';

FlutterTts flutterTts = new FlutterTts();
var lang = "en-US";

class FirebaseService {
  //create Account Using email and password

  void register(BuildContext context, String email, String password,
      String username) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    ProgressDialog progressDialog;

    //progress dialog start
    progressDialog = new ProgressDialog(context);

    progressDialog.style(
        message: '    Signing Up ..',
        borderRadius: 5.0,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        progressWidget: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600));

    //progress dialog ends

    progressDialog.show();
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser == null) {
      try {
        FirebaseUser createUser =
            (await firebaseAuth.createUserWithEmailAndPassword(
                    email: email, password: password))
                .user;
        //adding user to the table or relation
        Firestore.instance
            .collection("users")
            .document(createUser.uid)
            .setData({
          "id": createUser.uid,
          "username": username,
          "email": email,
        });

        progressDialog.hide();
        Fluttertoast.showToast(msg: "Account Created Successfully");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TextToSpeech()));
      } catch (e) {
        progressDialog.hide();
        Fluttertoast.showToast(
            msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  //Login using email and password

  void login(BuildContext context, String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    ProgressDialog progressDialog;

    //progress dialog start
    progressDialog = new ProgressDialog(context);

    progressDialog.style(
        message: '    Signing In ..',
        borderRadius: 10.0,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        progressWidget: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600));

    //progress dialog ends
    progressDialog.show();
    try {
      FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      progressDialog.hide();
      print("${user.uid}");
      Fluttertoast.showToast(msg: "Welcome");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => TextToSpeech()));
    } catch (e) {
      progressDialog.hide();
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //google sign in
  Future handleSignIn(BuildContext context) async {
    GoogleSignIn googleSignIn = new GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    ProgressDialog progressDialog;

    //progress dialog start
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
        message: '    Signing In ..',
        borderRadius: 30.0,
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        progressWidget: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.w600));

    //progress dialog ends

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      progressDialog.show();
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        //adding user to the table or relation
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoUrl,
          "email": firebaseUser.email,
        });
      }
      progressDialog.hide();
      Fluttertoast.showToast(msg: "Welcome");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => TextToSpeech()));
    } else {
      Fluttertoast.showToast(msg: "Login Failed");
    }
  }

//check for google sign in
  void checkUserIsSignnedIn(BuildContext context) async {
    GoogleSignIn googleSignIn = new GoogleSignIn();
    bool isLoggedIn = await googleSignIn.isSignedIn();

    if (isLoggedIn) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => TextToSpeech()));
    }
  }

  //return the current user
  Future<FirebaseUser> getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser();
  }

  //signout dialog
  void showAlertDialog(BuildContext context) {
    showDialog(
        barrierColor: Color.fromRGBO(19, 19, 19, 0.8),
        context: context,
        child: CupertinoAlertDialog(
          title: Text(
            "Sign out?",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Are you sure you want to sign out?",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
                textStyle: TextStyle(color: Colors.red),
                isDefaultAction: true,
                onPressed: () async {
                  signOut(context);
                },
                child: Text("Yes")),
            CupertinoDialogAction(
                textStyle: TextStyle(color: Colors.green),
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No")),
          ],
        ));
  }

  //signout method
  void signOut(BuildContext context) {
    GoogleSignIn googleSignIn = new GoogleSignIn();
    googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SignIn()),
        (Route<dynamic> route) => false);
  }

  //save data to firebase

  void saveToDatabase(String text) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      var id = Uuid();
      var userId = firebaseUser.uid.toString();
      String uuid = id.v1().toString();
      Firestore.instance.collection(userId).document(uuid.toString()).setData({
        "Text": text,
        "Id": uuid,
      });
    });
  }

  //delete alert dialog box
  deleteDialog(BuildContext context, String textID) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Delete History",
                style: TextStyle(
                  color: Colors.white,
                )),
            content: Text(
              "Are you sure you want to delete history?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: () async {
                    deleteHistory(textID, context);
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Recent()));
                  },
                  child: Text("Yes")),
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.green),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  //delete export history
  deleteExportDialog(BuildContext context, String textID) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Delete History",
                style: TextStyle(
                  color: Colors.white,
                )),
            content: Text(
              "Are you sure you want to delete history?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: () async {
                    deleteExportHistory(textID, context);
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ExportHistory()));
                  },
                  child: Text("Yes")),
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.green),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  //delete all dialog box
  allDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Delete History",
                style: TextStyle(
                  color: Colors.white,
                )),
            content: Text(
              "Are you sure you want to delete entire history?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: () async {
                    deleteAll(context);
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => ConvertTts()));
                  },
                  child: Text("Yes")),
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.green),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  //exprot delete all
  allExportDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Delete History",
                style: TextStyle(
                  color: Colors.white,
                )),
            content: Text(
              "Are you sure you want to delete entire history?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: () async {
                    deleteExportAll(context);
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => GenerateAudio()));
                  },
                  child: Text("Yes")),
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.green),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  //delete all history

  void deleteExportAll(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      print("${firebaseUser.uid.toString()}");
      Firestore.instance
          .collection(firebaseUser.uid.toString()+'temp')
          .getDocuments()
          .then((value) {
        for (DocumentSnapshot doc in value.documents) {
          print(doc['Id']);
          firebaseAuth.currentUser().then((firebaseUser) {
          Firestore.instance.collection(firebaseUser.uid.toString()+'temp').document(doc['Id'].toString()).delete();});
        }
      });
    });
    Fluttertoast.showToast(msg: "History Deleted");
  }


  //delete all history

  void deleteAll(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      print("${firebaseUser.uid.toString()}");
      Firestore.instance
          .collection(firebaseUser.uid.toString())
          .getDocuments()
          .then((value) {
        for (DocumentSnapshot doc in value.documents) {
          print(doc['Id']);
          firebaseAuth.currentUser().then((firebaseUser) {
          Firestore.instance.collection(firebaseUser.uid.toString()).document(doc['Id'].toString()).delete();});
        }
      });
    });
    Fluttertoast.showToast(msg: "History Deleted");
  }

  //delete the history
  void deleteHistory(String textID, BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      print("${firebaseUser.uid.toString()}");
      print("${textID.toString()}");
      Firestore.instance
          .collection(firebaseUser.uid.toString())
          .document(textID.toString())
          .delete();
    });
    Fluttertoast.showToast(msg: "History Deleted");
  }

  void deleteExportHistory(String textID, BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      print("${firebaseUser.uid.toString()}");
      print("${textID.toString()}");
      Firestore.instance
          .collection(firebaseUser.uid.toString() + 'temp')
          .document(textID.toString())
          .delete();
    });
    Fluttertoast.showToast(msg: "History Deleted");
  }

//create text to mp3 files
  Future createFile(String text, String fileName) async {
    await flutterTts.synthesizeToFile(text, "$fileName.wav");
    Fluttertoast.showToast(msg: "Audio File Generated");
  }

  //save export audio database
  void saveExportDatabase(String text, String fileName) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.currentUser().then((firebaseUser) {
      var id = Uuid();
      var userId = firebaseUser.uid.toString() + 'temp';
      String uuid = id.v1().toString();
      Firestore.instance.collection(userId).document(uuid.toString()).setData({
        "FileName": fileName,
        "Text": text,
        "Id": uuid,
      });
    });
  }

  //speak method
  Future speak(String text) async {
    // print("${await flutterTts.getLanguages}");
    await flutterTts.setLanguage(lang.toString());
    await flutterTts.speak(text);
    await flutterTts.setPitch(1);
  }

  //stop method
  Future stop() async {
    await flutterTts.stop();
  }
}
