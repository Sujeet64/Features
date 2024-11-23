//Dart libraries
import 'package:flutter/material.dart';
//third-party libraries
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//project level libraries
import 'WeatherApi.dart';
import 'components/My_TextField'; 
import 'components/My_BaseButton';
import 'components/Squared_Tile';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false; // Use this for the loading state

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

// Custom Sign-Up Logic
        Future<void> signUpWithEmailPassword(String email, String password) async {
          try {
            UserCredential userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
            print("User registered: ${userCredential.user?.email}");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print("The password provided is too weak.");
            } else if (e.code == 'email-already-in-use') {
              print("The account already exists for that email.");
            } else if (e.code == 'invalid-email') {
              print("Invalid email address.");
            }
          } catch (e) {
            print(e.toString());
          }
        }

// Custom Sign-In Logic
        Future<void> signInWithEmailPassword(String email, String password) async {
          try {
            UserCredential userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password,
            );
            print("User signed in: ${userCredential.user?.email}");
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print("No user found for that email.");
            } else if (e.code == 'wrong-password') {
              print("Wrong password provided.");
            }
          } catch (e) {
            print(e.toString());
          }
        }
//Google Sign in Logic
       Future<User?> signInWithGoogle() async {
        try {
          // Trigger the Google Authentication flow
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          if (googleUser == null) {
            // User canceled the sign-in
            return null;
          }

          // Obtain the auth details from the request
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          // Create a new credential
          final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          // Sign in to Firebase with the Google credential
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          return userCredential.user;
        } catch (e) {
          print('Google Sign-In Error: $e');
          return null;
        }
      }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width * 0.4,
                height: height * 0.28,
                child: Icon(
                  Icons.lock,
                  size: height * 0.12,
                ),
              ),
            ),

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
// Email
            SizedBox(height: height * 0.02),
            MyTextField(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            SizedBox(height: height * 0.02),
// Password
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            SizedBox(height: height * 0.02),

// Forgot Password
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

// Sign In
            SizedBox(
              height: height * 0.09,
              child: isLoading
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: 100,
                    )
                  // Show spinner while loading
                  : BaseButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });

                        signInWithEmailPassword(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ).then((_) {
                          print("Sign-in successful!");
                        }).catchError((error) {
                          print("Error: $error");
                        }).whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                      text: "Sign In",
                      width: width * 0.86,
                      height: height * 0.09,
                      fontSize: 16 * textScale,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      borderRadius: 7,
                    ),
            ),

            SizedBox(height: height * 0.04),

// Or continue with
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: Color.fromARGB(255, 87, 87, 87),
                    thickness: 0.06,
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
                const Expanded(
                  child: Divider(
                    color: Color.fromARGB(255, 87, 87, 87),
                    thickness: 0.06,
                  ),
                ),
              ],
            ),

// Google and Apple Sign-In
            SizedBox(height: height * 0.04),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquaredTile(
                  imagePath: 'assets/Google.png',
                  onTap: () {
                    print("clicked on google");
                    signInWithGoogle();
                    
                    
                  },
                ),
                const SizedBox(width: 24),
                SquaredTile(imagePath: 'assets/Apple.png',
                onTap: () => print("clicked on apple"),
                ),
              ],
            ),

            SizedBox(height: height * 0.04),

// Not a member? Register now
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