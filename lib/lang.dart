import 'package:flutter/material.dart';
import 'CRUD.dart';
import 'exportHistory.dart';

var cur = "English";


class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {

  @override
  void initState() {
    super.initState();
    firebaseService.stop();
  }

  @override
  void dispose() {
    super.dispose();
    firebaseService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
              child: Text(
            "Choose Default Language",
            style: TextStyle(
              fontFamily: "Montserrat Regular",
              fontSize: 15.0,
              color: Color(0xffffffff),
            ),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "en-US";
                      cur = "English";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: new Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/English.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "English",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "ta";
                      cur = "Tamil";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/Tamil.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "Tamil",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "fr-FR";
                      cur = "French";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/French.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "French",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "zh-CN";
                      cur = "Chinese";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: new Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/Chinese.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "Chinese",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "ko-KR";
                      cur = "Korean";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/Korean.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "Korean",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "de-DE";
                      cur = "German";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/German.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "German",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "ru-RU";
                      cur = "Russian";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: new Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/Russian.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "Russian",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "hi-IN";
                      cur = "Hindi";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/Hindi.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "Hindi",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      lang = "ja-JP";
                      cur = "Japanese";
                    });
                  },
                  child: Container(
                    height: 110.00,
                    width: 95.00,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(19, 19, 19, 0.6),
                      borderRadius: BorderRadius.circular(20.00),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 17.0),
                          child: Container(
                            height: 56.00,
                            width: 56.00,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/Japanese.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: new Text(
                              "Japanese",
                              style: TextStyle(
                                fontFamily: "Montserrat Regular",
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
              child: Text(
            "Current Language : $cur",
            style: TextStyle(
              fontFamily: "Montserrat Regular",
              fontSize: 15.0,
              color: Color(0xffffffff),
            ),
          )),
        ),
      ],
    ));
  }
}
