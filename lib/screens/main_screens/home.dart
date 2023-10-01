import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sudhaar/screens/main_screens/addrequest.dart';
import 'package:sudhaar/screens/main_screens/profile.dart';
import 'package:sudhaar/screens/main_screens/requestdone.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Tell us your problem, Raise a request here.',
                    style: GoogleFonts.kanit(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: HexColor('#004225'),
                            decoration: TextDecoration.underline)),
                  )),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Image(
                  image: AssetImage('assets/images/Garbagemanagement.jpg')),
            ),
            Text(
              'Garbage Management in Public Area',
              style:
                  GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 20)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Image(
                  image: AssetImage('assets/images/Electrician.jpg')),
            ),
            Text(
              'Solving the Power Cut issues',
              style:
                  GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 20)),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
