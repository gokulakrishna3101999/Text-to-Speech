import 'package:flutter/material.dart';
import 'TextToSpeech.dart';
import 'signin.dart';
import 'CRUD.dart';


var passVisible = Icons.visibility;
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
FirebaseService fireBaseService = new FirebaseService();
bool pass=true;


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final formKey2 = GlobalKey<FormState>();

@override
  void initState() {
    super.initState();
    fireBaseService.getUser().then((user)
    {
      if(user!=null)
      Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => TextToSpeech()));
      else
      fireBaseService.checkUserIsSignnedIn(context);
    });
  }

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
        elevation:0.0,
        actions: 
        [
           FlatButton
                   (
                     onPressed: ()
                     {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUp()));
                     }, 
                     child: Text("Sign up",style: TextStyle(fontFamily: "Montserrat Regular",fontSize: 15.0,color:Color(0xffffffff),),)
                   )
        ],
      ),
       body: Form
       (
         key: formKey2,
         child: ListView
         (
           children: <Widget>
           [
             Padding(
               padding: const EdgeInsets.only(top:20.0),
               child: Center(child: Text("Log in",style: TextStyle(fontFamily: "Montserrat Bold",fontWeight: FontWeight.w700,fontSize: 26,color:Color(0xffffffff),),)),
             ),
             Padding(
             padding: const EdgeInsets.only(top:40.0,left:150.0,right: 138.0),
             child:CircleAvatar
                       (
                         maxRadius: 60.0,
                         minRadius: 40.0,
                         backgroundColor: Color.fromRGBO(40,40,40,1),
                         child: Image.asset('images/logo.png',fit: BoxFit.cover,)
                       ),
           ),
            Padding(
              padding: const EdgeInsets.only(left:35.0,right:35.0,top: 40.0),
              child: TextFormField
              (
                controller: emailController,
                decoration: new InputDecoration
                (
                  border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(30.0),),),
                  filled: true,
                  hintStyle: new TextStyle(color:Color(0xff989898),fontFamily:"Montserrat Regular",fontSize: 13.0),
                  hintText: "Mail Id",
                  fillColor: Colors.white,
                  prefixText: '   '
                ),
                validator: (value)
                {
                    return value.isEmpty ? 'Mail Id is required' : null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0,right:35.0,top: 10.0),
              child: TextFormField
              (
                controller: passwordController,
                obscureText: pass,
                decoration: new InputDecoration
                (
                  border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(30.0),),),
                  filled: true,
                  hintStyle: new TextStyle(color:Color(0xff989898),fontFamily:"Montserrat Regular",fontSize: 13.0),
                  hintText: "Password",
                  fillColor: Colors.white,
                  prefixText: '   ',
                  suffixIcon: InkWell
                  (
                    borderRadius:BorderRadius.circular(20.00),
                    onTap: ()
                    {
                      setState(() {
                      if(pass==true)
                      {
                        passVisible = Icons.visibility_off;
                        pass=false;
                      }
                      else
                      {
                        passVisible = Icons.visibility;
                        pass=true;
                      }         
                    });
                    },
                    child: CircleAvatar
                    (
                           maxRadius: 20.0,
                           minRadius: 20.0,
                           backgroundColor: Colors.white,
                           child: Icon(passVisible,color: Colors.grey,size: 17.0),
                    ),
                  ), 
                  ),
                  validator: (value)
                  {
                    return value.isEmpty ? 'Password is required' : null;
                  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:35.0,right:35.0,top: 29.0),
              child: InkWell
              (
                borderRadius:BorderRadius.circular(32.00),
                onTap: ()
                {
                  FormState formState = formKey2.currentState;
                             if(formState.validate())
                             {
                               fireBaseService.login(context, emailController.text, passwordController.text);
                               formState.reset();
                             } 
                },
                child: Container
                (
                child: Center
                (
                  child: Text("Log in",style: TextStyle(fontFamily: "Montserrat Regular",fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold),)
                ),
                height: 45.00,
                width: 252.00,
                decoration: BoxDecoration
                (
                  gradient: LinearGradient(begin: Alignment.centerLeft,end: Alignment.centerRight,colors: [Color.fromRGBO(255,148,90,1),Color.fromRGBO(255,128,51,1)]),
                  color: Color(0xffff8033),borderRadius: BorderRadius.circular(30.00),
                ), 
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: Center
              (
                child: Text("Or Login with",style: TextStyle(fontFamily: "Montserrat Regular",fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Center
              (
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>
                  [
                     InkWell
                     (
                       borderRadius:BorderRadius.circular(15.00),
                       onTap: ()
                       {
                         fireBaseService.handleSignIn(context);
                       },
                       child: CircleAvatar
                       (
                         maxRadius: 20.0,
                         minRadius: 20.0,
                         backgroundColor: Colors.white,
                         child: Image.asset('images/Google.png',fit: BoxFit.cover,)
                       ),
                     ),
                     
                  ],
                ),
              ),
            ),
            SizedBox(height:20.0)
           ],
         ),
       ),
    );
  }
}

/*
IconButton(icon: Icon(passVisible,color: Colors.grey,size: 17.0), 
                  onPressed: ()
                  {
                    
                  })
*/