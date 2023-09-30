import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sudhaar/authentication/auth_screens/signuppage.dart';
import '../../screens/main_screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  // Function to validate if the email address is in the correct format.
  bool _isValidEmail(String email) {
    final emailRegExp =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      final User? user = authResult.user;
      if (user != null) {
        // Logged in successfully, navigate to profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              // Pass user information to the profile page
              userName: user.displayName,
              userEmail: user.email,
              userPhoneNumber: user.phoneNumber,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Error Code: ${e.code}");

      if (e.code == 'user-not-found') {
        _showSnackBar("User not found");
      } else if (e.code == 'invalid-credential') {
        _showSnackBar("Invalid login credentials");
      } else {
        _showSnackBar("An error occurred");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: HexColor("#F5F5DC"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                //big circle
                ClipPath(
                  clipper: Clip3(),
                  child: Container(
                    height: 400,
                    width: 550,
                    color: HexColor("#004225"),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 100,
                  child: ClipPath(
                    clipper: Clip5(),
                    child: Container(
                      width: 110,
                      height: 350,
                      decoration: BoxDecoration(
                          color: Color(0xFF103303).withOpacity(0.7)),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: Clip4(),
                  child: Container(
                    width: 180,
                    height: 100,
                    decoration: BoxDecoration(color: Color(0xFF315431)),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 60,
                  child: Text(
                    "Welcome \nBack",
                    style: GoogleFonts.kanit(
                        textStyle: const TextStyle(color: Colors.white),
                        fontSize: 39,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.email_outlined),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: passwordVisible,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.password_outlined),
                        prefixIconColor: Colors.grey,
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (Text) {
                        if (Text == null || Text.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(
                              color: Color(0xFF472C0C),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              height: 1)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Valid form, you can proceed with login.
                              signInWithEmailAndPassword();
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => HomePage()));
                            }
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.kanit(
                                textStyle: TextStyle(
                                    color: HexColor("#004225"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 39)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF004225),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_outlined),
                          color: Color(0xFFF5F5DC),
                          iconSize: 40,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      'New user? Sign up',
                      style: GoogleFonts.kanit(
                          textStyle: TextStyle(color: Color(0xFF472C0C)),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Clip3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 150);
    var firststart2 = Offset(size.width / 2, size.height);
    var firstend2 = Offset(size.width, size.height - 150);
    path.quadraticBezierTo(
        firststart2.dx, firststart2.dy, firstend2.dx, firstend2.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Clip4 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var firststart2 = Offset(size.width - 100, size.height);
    var firstend2 = Offset(size.width, size.height - 100);
    path.quadraticBezierTo(
        firststart2.dx, firststart2.dy, firstend2.dx, firstend2.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Clip5 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0 + 15);
    var firststart2 = Offset(size.width - 220, size.height / 2);
    var firstend2 = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
        firststart2.dx, firststart2.dy, firstend2.dx, firstend2.dy);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
