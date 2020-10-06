import 'package:flutter/material.dart';
import 'package:tts/exportHistory.dart';
import 'TextToSpeech.dart';
import 'lang.dart';


String userID='';

class GenerateAudio extends StatefulWidget {
  @override
  _GenerateAudioState createState() => _GenerateAudioState();
}

class _GenerateAudioState extends State<GenerateAudio> {

final formKey3  = GlobalKey<FormState>();
TextEditingController fileNameController = new TextEditingController();
TextEditingController audioTextController = new TextEditingController();

@override
  void dispose() {
    super.dispose();
    firebaseService.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        leading:FlatButton
            (
                 onPressed: () 
                 {
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TextToSpeech()));
                 },
                 child: Icon(Icons.arrow_back_ios,size: 15.0,color: Colors.white,),
            ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
                FlatButton
                   (
                     onPressed: ()
                     {
                       fireBaseService.showAlertDialog(context);
                     }, 
                     child: Image.asset('images/dots.png',height: 17.0,),
                   )
             ],  
      ),  
      body: Form
      (
        key: formKey3,
        child: ListView
        (
          children: 
          [
             Padding(
              padding: const EdgeInsets.only(top: 20.0,left:15.0,right: 15.0 ),
              child: TextFormField
              (
                controller: fileNameController,
                decoration: new InputDecoration
                (
                  border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(20.0),),),
                  filled: true,
                  hintStyle: new TextStyle(fontFamily:"Montserrat Regular"),
                  hintText: "File Name ",
                  fillColor: Colors.white,
                  prefixText: '   '
                ),
                validator: (value)
                {
                    return value.isEmpty ? 'File name required !' : null;
                },
              ),
            ),
            Padding(
             padding: const EdgeInsets.only(top:20.0,left:15.0,right: 15.0),
              child: TextFormField
                (
                 maxLines: 17,
                 controller: audioTextController,
                 decoration: InputDecoration
                 (
                   filled: true,
                   fillColor: Colors.white,
                   prefix: Text(" "),
                   hintText: 'Enter your text here',
                   hintStyle: TextStyle(fontFamily: "Montserrat Regular"),
                   border: new OutlineInputBorder
                   (
                     borderRadius: const BorderRadius.all(const Radius.circular(20.0),)
                   ),
                 ),
                 validator: (val)
                 {
                   if(val.isEmpty)
                   return 'Please enter some text !';
                   else
                   return null;
                 },
                 ),
           ),
           Row
           (
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>
             [
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Center
                (
                   child:InkWell
                         (
                           borderRadius:BorderRadius.circular(15.00),
                           onTap: ()
                           {
                             fileNameController.clear();
                             audioTextController.clear();
                           },
                           child: new Container
                           (
                             height: 40.0,
                             width: 40.0,
                             decoration: BoxDecoration
                             (
                               image: DecorationImage(image: AssetImage("images/delete.png",),),
                             ), 
                           ),
                         ),
                ),
              ),
              Padding
              (
                padding: const EdgeInsets.only(top:10.0,left:10.0),
                child: InkWell
                       (
                         borderRadius:BorderRadius.circular(15.00),
                         onTap: ()
                         {
                           Navigator.push(
                            context, MaterialPageRoute(builder: (BuildContext context) => Language()));
                         },
                         child: new Container
                         (
                           height: 40.0,
                           width: 40.0,
                           decoration: BoxDecoration
                           (
                             image: DecorationImage(image: AssetImage("images/lang.png",),),
                           ), 
                         ),
                       ),
                 ),
             ],
           ),
           Padding(
             padding: const EdgeInsets.only(top:15.0,left: 130.0,right: 130.0),
             child: RaisedButton
             (
               elevation: 1.0,
               hoverColor: Color.fromRGBO(40,40,40,1),
               color: Colors.white,
               onPressed: ()
               {
                FormState formState = formKey3.currentState;
                if(formState.validate())
                {
                    firebaseService.createFile(audioTextController.text,fileNameController.text);
                    fireBaseService.saveExportDatabase(audioTextController.text,fileNameController.text);
                }
               },
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
               child:Center(child: Text("Export !",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Montserrat Regular",color: Colors.indigo),)),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top:8.0,left: 5.0),
              child: Center
              (
                child:InkWell
                (
                  onTap: ()
                  {
                   fileNameController.clear();
                   audioTextController.clear();
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ExportHistory()));
                  },
                  child: Text("Recent",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Montserrat Regular",color: Colors.white),)
                ),
              ),
              ),
            Center
             (
              child:  InkWell
              (
                borderRadius:BorderRadius.circular(20.00),
                onTap: ()
                {
                   fileNameController.clear();
                   audioTextController.clear();
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ExportHistory()));
                },
                child: CircleAvatar
                (
                  maxRadius: 10.0,
                  minRadius: 10.0,
                  backgroundColor: Color.fromRGBO(40,40,40,1),
                  child: Icon(Icons.arrow_drop_up,size: 30.0,color:Colors.white)
                ),         
              ),
             ),
           SizedBox(height:20.0)
          ],
        )
      ),
    );
  }
}