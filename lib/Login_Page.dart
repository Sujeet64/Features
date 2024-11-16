import 'package:flutter/material.dart';
import 'components /My_TextField';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width; 
    final orientation = MediaQuery.of(context).orientation; 
     final textScale = MediaQuery.of(context).textScaler;
    return   Scaffold(
      backgroundColor:  const Color.fromARGB(255, 234, 234, 234),
      body: SafeArea(
        child:Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
              width: width*0.4,
              height: height*0.3,
              child: Icon(Icons.lock,
              size: height*0.12,
              ),
            )
            ),
            SizedBox(height: height*0.001,),
            Text("Welcome back you\'ve been missed!",
            
            style: TextStyle(
              fontSize: textScale.scale(16),
              fontWeight: FontWeight.w300, 
              fontFamily: 'sans-serif',
              color: const Color.fromARGB(255, 87, 87, 87),
              
            ),
            ),
            SizedBox(height: height*0.02,),
            MyTextField(
              controller: emailController ,
              hintText: "Email",
              obscureText: false,
            ),
            SizedBox(height: height*0.02,),
            MyTextField(
              controller: ,
              hintText: "Password",
              obscureText: true,


            ),


          ],
        )
        ),
    );
  }
}