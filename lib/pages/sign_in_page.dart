import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/pages/etkinlik_page.dart';
import 'package:flutter_restapi/pages/sign_up_page.dart';
import 'package:flutter_restapi/user_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Column(children: [
        Text('Welcome Again',style: TextStyle(fontSize: 45),),
        SizedBox(height: 20,),
        Text('Email Address'),
        TextField(controller: _emailController,),
        Text('Password'),
        TextField(controller: _passwordController,),
        
        ElevatedButton(onPressed:() async{AuthService().signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);},
         child: Text('Sign In')),
        SizedBox(height: 30,),
        Text('If you dont have an account'),
        TextButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => SignUpPage() ));
        }, child: Text('Sign Up')),

      ],),),
    );
  }
}