import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../authentication/auth_screens/loginpage.dart';
import '../../authentication/auth_screens/signuppage.dart';
import 'homepage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var presscount = 0;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential authResult =
        await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Successfully signed in with Google
          // You can navigate to the desired screen or perform other actions here
        }
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  Future<User?> _handleFacebookSignIn() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final AuthCredential credential = FacebookAuthProvider.credential(
          accessToken.token,
        );

        final UserCredential authResult =
        await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null) {
          // Successfully signed in with Facebook
          // You can navigate to the desired screen or perform other actions here
          return user;
        }
      }
    } catch (error) {
      print("Facebook Sign-In Error: $error");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        presscount++;
        if (presscount == 2) {
          exit(0);
        } else {
          final snack = const SnackBar(
            content: Text('Press back button again to exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return Future.value(false);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    'Sudhaar',
                    style: GoogleFonts.kanit(
                      textStyle: const TextStyle(fontSize: 50),
                      fontWeight: FontWeight.bold,
                      color: HexColor('#004225'),
                    ),
                  ),
                  Text(
                    "Connect with Us",
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        height: 2,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        fontSize: 19,
                        color: HexColor('#004225'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                          color: HexColor('#F5F5DC'),
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 100.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF004225),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or',
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                          color: Color(0xFFF5F5DC),
                          fontWeight: FontWeight.bold,
                          fontSize: 34,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 90.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF004225),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Or Continue using',
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _handleGoogleSignIn,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF004225),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 40,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final user = await _handleFacebookSignIn();
                          if (user != null) {
                            // Successfully signed in with Facebook
                            // You can navigate to the desired screen or perform other actions here
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF004225),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/fb.png',
                            height: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
