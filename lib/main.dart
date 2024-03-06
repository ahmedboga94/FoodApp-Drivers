import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodappdrivers/homescreens/earnings_screen.dart';
import 'package:foodappdrivers/homescreens/history_screen.dart';
import 'package:foodappdrivers/homescreens/home_screen.dart';
import 'package:foodappdrivers/homescreens/new_order_screen.dart';
import 'package:foodappdrivers/authentication/auth_screen.dart';
import 'package:foodappdrivers/global/global.dart';
import 'package:foodappdrivers/homescreens/not_delivered_screen.dart';
import 'package:foodappdrivers/homescreens/parcel_in_progress_screen.dart';
import 'package:foodappdrivers/splashscreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food Sales",
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        AuthScreen.id: (context) => const AuthScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        NewOrderScreen.id: (context) => const NewOrderScreen(),
        ParcelInProgressScreen.id: (context) => const ParcelInProgressScreen(),
        NotDeliveredScreen.id: (context) => const NotDeliveredScreen(),
        HistoryScreen.id: (context) => const HistoryScreen(),
        EarningsScreen.id: (context) => const EarningsScreen(),
      },
      initialRoute: SplashScreen.id,
    );
  }
}
