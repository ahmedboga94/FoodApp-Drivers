import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodappdrivers/homescreens/home_screen.dart';
import 'package:foodappdrivers/authentication/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  static String id = "splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    if (FirebaseAuth.instance.currentUser != null) {
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      });
    } else {
      Future.delayed(const Duration(seconds: 4),
          () => Navigator.of(context).pushReplacementNamed(AuthScreen.id));
    }
  }

  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent);

  @override
  void initState() {
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.top]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset("assets/images/logo.png")),
              const SizedBox(height: 10),
              const Text(
                "World's Largest online Food App",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                    fontFamily: "Signatra",
                    letterSpacing: 2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
