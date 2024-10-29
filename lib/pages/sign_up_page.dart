import 'package:flutter/material.dart';
import 'package:flutter_restapi/pages/sign_in_page.dart';
import 'package:flutter_restapi/user_auth/firebase_auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Register Account',style: TextStyle(fontSize: 45,),),
            SizedBox(height: 60,),
            Text('Email Address'),
            TextField(controller: _emailController,),
            Text('Password'),
            TextField(controller: _passwordController,),
            ElevatedButton(onPressed: 
            () async{
              AuthService().signUp(email: _emailController.text,
               password: _passwordController.text,
               context: context);
            },child: Text('Sign Up'),),
            Text('If you already have an account'),
            TextButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) => SignInPage() ));
          },  child: Text('Sign In')),
          ],
        ),
      ),
    );
  }
}