import 'package:flutter/material.dart';
import 'components /My_TextField'; // Ensure this import path is correct
import 'components /My_BaseButton';
import 'components /Squared_Tile';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      body: SafeArea(
        
        child: Column(
          
          
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width * 0.4,
                height: height * 0.3,
                child: Icon(
                  Icons.lock,
                  size: height * 0.12,
                ),
              ),
            ),
            SizedBox(height: height * 0.001),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                fontSize: 16 * textScale,
                fontWeight: FontWeight.w300,
                fontFamily: 'sans-serif',
                color: const Color.fromARGB(255, 87, 87, 87),
              ),
              textAlign: TextAlign.center,
            ),
        //Email
            SizedBox(height: height * 0.02),
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            SizedBox(height: height * 0.02),
        //Password
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
              
            ),

            SizedBox(height: height * 0.02),
        //forgot password
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 26),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 12 * textScale,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'sans-serif',
                    color: const Color.fromARGB(255, 87, 87, 87),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.03),
        //Sign In
            BaseButton(
            onPressed: () {},
            text: "Sign In",
            width: width * 0.86,
            height: height * 0.09,
            fontSize: 16 * textScale,
            fontWeight: FontWeight.w500,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            borderRadius: 7,
          ),

          SizedBox(height: height * 0.04),

//or continue with
          Row(
            children: [
              const Expanded(child: Divider(
            color: Color.fromARGB(255, 87, 87, 87),
            thickness: 0.2,
            
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Or continue with",
              style: TextStyle(
                fontSize: 12 * textScale,
                fontWeight: FontWeight.w500,
                fontFamily: 'sans-serif',
                color: const Color.fromARGB(255, 87, 87, 87),
              ),
            ),
          ),
          const Expanded(child: Divider(
            color: Color.fromARGB(255, 87, 87, 87),
            thickness: 0.2,
            
          ),
          ),
          ],
          ),

    //Google Apple Sign In
            SizedBox(height: height * 0.03),
             const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquaredTile(imagePath: 'assets/Google.png'),
                SizedBox(width: 20),
                SquaredTile(imagePath: 'assets/Apple.png'),
               

                
              ],
            ),
            




            SizedBox(height: height * 0.02),
     //Not a member, register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Not a member?",
                  style: TextStyle(
                    fontSize: 12 * textScale,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'sans-serif',
                    color: const Color.fromARGB(255, 87, 87, 87),
                  ),
                ),

                Text(
                  " Register now",
                  style: TextStyle(
                    fontSize: 12 * textScale,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'sans-serif',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
