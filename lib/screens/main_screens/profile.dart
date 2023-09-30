import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sudhaar/screens/main_screens/welcome.dart';
import '../../authentication/auth_screens/loginpage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: HexColor('#F5F5DC'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    color: HexColor("#004225"),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: HexColor("#F5F5DC"),
                        ),
                        shape: BoxShape.circle),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: HexColor("#F5F5DC"),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: user?.photoURL != null
                            ? NetworkImage(user!.photoURL ?? '')
                            : null, // Use null if there's no profile pic
                        backgroundColor: HexColor('#FF126029'), // Fallback background color
                        child: user?.photoURL == null
                            ? Text(
                          user != null
                              ? (user.displayName != null && user.displayName!.isNotEmpty
                              ? user.displayName![0].toUpperCase()
                              : user.email != null && user.email!.isNotEmpty
                              ? user.email![0].toUpperCase()
                              : "?")
                              : "?",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                          ),
                        )
                            : null, // Don't display text if there's a profile pic
                      ),
                    ),

                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    'Your Profile',
                    style: GoogleFonts.kanit(
                      textStyle: TextStyle(
                        color: HexColor('#F5F5DC'),
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Display user data here
            buildUserDataItem(Icons.person, ' ${user?.displayName ?? ""}'),
            buildUserDataItem(Icons.email_outlined, ' ${user?.email ?? ""}'),
            buildUserDataItem(Icons.phone, ' ${user?.phoneNumber ?? "N/A"}'),
            SizedBox(height: 160,),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                HexColor("#004225"),
              )),
              onPressed: _signOut,
              child: Text(
                'LogOut',
                style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                  color: HexColor('#F5F5DC'),
                  fontSize: 20,
                )),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }

  // Helper function to create a row for user data
  Widget buildUserDataItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                text,
                style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: HexColor('#004225'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 200);
    var firststart2 = Offset(size.width / 4, size.height - 100);
    var firstend2 = Offset(size.width, size.height - 250);
    path.quadraticBezierTo(
      firststart2.dx,
      firststart2.dy,
      firstend2.dx,
      firstend2.dy,
    );
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
