import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sudhaar/screens/main_screens/history.dart';
import 'package:sudhaar/screens/main_screens/profile.dart';
import 'package:sudhaar/screens/main_screens/requestdone.dart';
import 'addrequest.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      String? userName,
      String? userEmail,
      String? userPhoneNumber});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Home(),
    const RequestDone(),
    const AddRequest(),
    const History(),
    const MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sudhaar',
          style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 50)),
        ),
        backgroundColor: HexColor('#F5F5DC'),
        elevation: 1,
        shadowColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: HexColor('#F5F5DC'),
      bottomNavigationBar: GNav(
        backgroundColor: HexColor('#004225'),
        iconSize: 30,
        activeColor: Colors.white,
        tabMargin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        tabs: [
          GButton(
            icon: Icons.home_rounded,
            iconColor: HexColor('#F5F5DC'),
          ),
          GButton(
            icon: Icons.check_circle,
            iconColor: HexColor('#F5F5DC'),
          ),
          GButton(
            icon: Icons.add_circle,
            iconColor: HexColor('#F5F5DC'),
          ),
          GButton(
            icon: Icons.history_rounded,
            iconColor: HexColor('#F5F5DC'),
          ),
          GButton(
            icon: Icons.person_rounded,
            iconColor: HexColor('#F5F5DC'),
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _pages.isNotEmpty
          ? _pages[_selectedIndex]
          : const SizedBox.shrink(), // Check if _pages is not empty
    );
  }
}
