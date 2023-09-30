import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../screens/main_screens/homepage.dart';
import 'loginpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(_emailController.text.trim()).set({
        'fullName': _fullNameController.text,
        'email': _emailController.text.trim(),
        'phoneNumber': _phoneNumberController.text,
        'addressLine1': _addressLine1Controller.text,
        'addressLine2': _addressLine2Controller.text,
        'pinCode': _pinCodeController.text,
      });

      // Registration success
      // You can navigate to another screen or show a success message here
      // For example, you can navigate to the homepage:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()), // Import your HomePage class
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // The email address is already in use by another account.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email address is already in use.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        // The email address is not valid.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email address.'),
          ),
        );
      } else {
        // Handle other registration errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed. Please try again later.'),
          ),
        );
      }
    }
  }

  bool _validateForm() {
    if (!_isValidEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
        ),
      );
      return false;
    }
    if (!_isValidPassword(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Password must be 6-15 characters with at least one uppercase, one lowercase, one number, and one symbol'),
        ),
      );
      return false;
    }
    if (!_isValidPhoneNumber(_phoneNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid Indian phone number'),
        ),
      );
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    final emailRegExp =
    RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,15}$');
    return passwordRegExp.hasMatch(password);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Regular expression for Indian phone numbers (10 digits starting with 6-9)
    final phoneRegExp = RegExp(r'^[6-9]\d{9}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: HexColor("#004225"),
        title: Text(
          'Sudhaar',
          style: GoogleFonts.kanit(
            textStyle: const TextStyle(fontSize: 40),
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF5F5DC),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: HexColor("#F5F5DC"),
          child: Column(
            children: [
              ClipPath(
                clipper: Clip1(),
                child: Container(
                  height: 185,
                  width: 550,
                  color: HexColor("#004225"),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(35, 70, 10, 35),
                    alignment: Alignment.bottomLeft,
                    child: Column(children: [
                      Text(
                        '  Create\nAccount',
                        style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            height: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      controller: _fullNameController,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.email_outlined),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
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
                        } else if (!_isValidEmail(value)) {
                          return 'Please enter a valid email address';
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
                      obscureText: !passwordVisible,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: const Icon(Icons.password_outlined),
                        prefixIconColor: Colors.grey,
                        hintStyle: const TextStyle(color: Colors.grey),
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
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        enabledBorder: const OutlineInputBorder(
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
                          return 'Please enter a password';
                        } else if (!_isValidPassword(value)) {
                          return 'Password must be 6-15 characters with at least one uppercase, one lowercase, one number, and one symbol';
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
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        counterText: '',
                        labelText: 'Contact Number ',
                        labelStyle: TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.phone),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
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
                          return 'Please enter your phone number';
                        } else if (!_isValidPhoneNumber(value)) {
                          return 'Please enter a valid Indian phone number';
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
                      controller: _addressLine1Controller,
                      keyboardType: TextInputType.streetAddress,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Address Line 1',
                        labelStyle: TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.location_on_outlined),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      controller: _addressLine2Controller,
                      keyboardType: TextInputType.streetAddress,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: 'Address Line 2',
                        labelStyle: TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.location_on_outlined),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 270,
                    child: TextFormField(
                      controller: _pinCodeController,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        counterText: '',
                        labelText: 'Pin Code',
                        labelStyle: TextStyle(color: Colors.brown, fontSize: 15),
                        prefixIcon: Icon(Icons.location_on_outlined),
                        prefixIconColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Stack(children: [
                ClipPath(
                  clipper: Clip2(),
                  child: Container(
                    color: HexColor("#004225"),
                    width: 550,
                    height: 205,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_validateForm()) {
                            // Form is valid, perform sign up here
                            createUserWithEmailAndPassword();
                          }
                        },
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.kanit(
                              textStyle: TextStyle(
                                  color: HexColor("#004225"),
                                  fontSize: 29,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF00673B)),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_sharp),
                          color: Colors.white,
                          iconSize: 38,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 110, 25, 0),
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        'Already have an\naccount? Login',
                        style: GoogleFonts.kanit(
                            textStyle: const TextStyle(
                                fontSize: 19,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                height: 1)),
                      )),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class Clip1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 45);
    var firstStart = Offset(size.width - 275, size.height + 20);
    var firstEnd = Offset(size.width - 200, size.height - 23);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width, 0);
    var secondEnd = Offset(size.width / 0.8, size.height - 205);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Clip2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    // path.lineTo(0,size.height);
    var firstStart1 = Offset(size.width / 5, size.height - 190);
    var firstEnd1 = Offset(size.width - 200, size.height + 350);
    path.quadraticBezierTo(
        firstStart1.dx, firstStart1.dy, firstEnd1.dx, firstEnd1.dy);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
