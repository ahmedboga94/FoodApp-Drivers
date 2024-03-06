import 'package:flutter/material.dart';
import 'package:foodappdrivers/authentication/login_screen.dart';
import 'package:foodappdrivers/authentication/register_screen.dart';

class AuthScreen extends StatefulWidget {
  static String id = "authScreen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.cyan,
            ],
          ))),
          title: const Text("iFood Drivers",
              style: TextStyle(fontFamily: "Signatra", fontSize: 50)),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.lock), text: "Login"),
              Tab(icon: Icon(Icons.person), text: "Register"),
            ],
            indicatorColor: Colors.white70,
            indicatorWeight: 3,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.cyan,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 1.0],
          )),
          child: const TabBarView(children: [
            LoginScreen(),
            RegisterScreen(),
          ]),
        ),
      ),
    );
  }
}
