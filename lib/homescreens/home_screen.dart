import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodappdrivers/authentication/auth_screen.dart';
import 'package:foodappdrivers/global/global.dart';
import 'package:foodappdrivers/model/driver_model.dart';
import 'package:foodappdrivers/widgets/app_app_bar.dart';
import 'package:foodappdrivers/widgets/dashboard_card.dart';
import 'package:foodappdrivers/widgets/error_dialog.dart';

class HomeScreen extends StatefulWidget {
  static String id = "homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getPerParcelDeliveryAmount() {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("boga94")
        .get()
        .then((snapShot) {
      perParcelDelivertAmount = snapShot.data()!["amount"].toDouble();
      print(" ==================== $perParcelDelivertAmount  delivery amount");
    });
  }

  getDriverPreviousEarings() {
    FirebaseFirestore.instance
        .collection("drivers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((docSnapshot) {
      previousDriverEarnings = docSnapshot.data()!["earning"].toDouble();
      print(" ==================== $previousDriverEarnings  driver");
    });
  }

  kikOutBlockedUsers() async {
    final navigator = Navigator.of(context);
    await FirebaseFirestore.instance
        .collection("drivers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        final driverModel =
            DriverModel.fromJson(snapshot.data() as Map<String, dynamic>);
        if (driverModel.status == "not approved") {
          FirebaseAuth.instance.signOut();
          navigator.pushNamedAndRemoveUntil(AuthScreen.id, (route) => false);
          showDialog(
              context: context,
              builder: (c) => const ErrorDialog(
                  message:
                      "You are blocked from Admin \n Contact on: admin@gmail.com"));
        }
      }
    });
  }

  @override
  void initState() {
    getPerParcelDeliveryAmount();
    getDriverPreviousEarings();
    kikOutBlockedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppAppBar(title: "Welcome ${sharedPreferences!.getString("name")}"),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: const [
            DashboardCard(
                title: "New Available Orders",
                iconData: Icons.assignment,
                index: 0),
            DashboardCard(
                title: "Parcels in Progress",
                iconData: Icons.airport_shuttle,
                index: 1),
            DashboardCard(
                title: "Not Deliverd Yet",
                iconData: Icons.location_history,
                index: 2),
            DashboardCard(title: "History", iconData: Icons.done_all, index: 3),
            DashboardCard(
                title: "Total Earnings",
                iconData: Icons.monetization_on,
                index: 4),
            DashboardCard(title: "Logout", iconData: Icons.logout, index: 5),
          ],
        ),
      ),
    );
  }
}
