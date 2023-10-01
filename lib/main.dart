import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sudhaar/authentication/auth_screens/loginpage.dart';
import 'package:sudhaar/firebase_options.dart';
import 'package:sudhaar/screens/main_screens/welcome.dart';
import 'components/locator.dart';
import 'screens/main_screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.removeAfter(initialization);
  runApp(const MyApp());
}
 Future initialization(BuildContext? context) async{
  await Future.delayed(Duration(seconds: 3));
 }
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    int _pressCount = 0; // Initialize the press count variable

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Set the initial route to '/'
      routes: {
        '/': (context) => WillPopScope(
          // Wrap your entire app with WillPopScope
          onWillPop: () async {
            if (_pressCount == 1) {
              // If back is pressed again within 2 seconds, exit the app
              return true; // Allow the app to exit
            } else {
              // Show a snackbar indicating the need to press again to exit
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Press back button again to exit'),
                  duration: Duration(seconds: 2),
                ),
              );

              // Increment the press count and set a timer to reset it after 2 seconds
              _pressCount++;
              Timer(Duration(seconds: 2), () {
                _pressCount = 0; // Reset the press count
              });

              // Prevent the app from exiting
              return false;
            }
          },
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final user = snapshot.data as User?;
                if (user != null) {
                  // If the user is already signed in, navigate to HomePage
                  return HomePage();
                } else {
                  // If the user is not signed in, navigate to WelcomePage
                  return WelcomePage();
                }
              } else {
                // Handle loading state
                return CircularProgressIndicator(); // or any loading widget
              }
            },
          ),
        ),
        '/login': (context) => LoginPage(), // Define the LoginPage route
        '/home': (context) => HomePage(), // Define the HomePage route
      },
    );
  }
}

void getLocation() async {
  final service = LocationService();
  final locationData = await service.getLocation();
  if(locationData != null){
    final placeMark = await service.getPlaceMark(locationData: locationData);

  }
}