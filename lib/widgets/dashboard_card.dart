import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodappdrivers/homescreens/earnings_screen.dart';
import 'package:foodappdrivers/homescreens/history_screen.dart';
import 'package:foodappdrivers/homescreens/new_order_screen.dart';
import 'package:foodappdrivers/authentication/auth_screen.dart';
import 'package:foodappdrivers/homescreens/not_delivered_screen.dart';
import 'package:foodappdrivers/homescreens/parcel_in_progress_screen.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final int index;
  const DashboardCard(
      {super.key,
      required this.title,
      required this.iconData,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          //new available order
          Navigator.of(context).pushNamed(NewOrderScreen.id);
        }
        if (index == 1) {
          //Parcels in progress
          Navigator.of(context).pushNamed(ParcelInProgressScreen.id);
        }
        if (index == 2) {
          //not yet delivered
          Navigator.of(context).pushNamed(NotDeliveredScreen.id);
        }
        if (index == 3) {
          //History
          Navigator.of(context).pushNamed(HistoryScreen.id);
        }
        if (index == 4) {
          //Total Earnings
          Navigator.of(context).pushNamed(EarningsScreen.id);
        }
        if (index == 5) {
          //Logout
          FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
              .pushNamedAndRemoveUntil(AuthScreen.id, (route) => false));
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: index == 0 || index == 2 || index == 4
              ? const BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    Colors.amber,
                    Colors.cyan,
                  ],
                ))
              : const BoxDecoration(
                  gradient: LinearGradient(
                  colors: [
                    Colors.redAccent,
                    Colors.amber,
                  ],
                )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(child: Icon(iconData, size: 40, color: Colors.black)),
              const SizedBox(height: 10),
              Center(
                  child: Text(title,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black))),
            ],
          ),
        ),
      ),
    );
  }
}
