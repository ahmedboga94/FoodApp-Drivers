import 'package:flutter/material.dart';
import 'package:foodappdrivers/global/global.dart';
import 'package:foodappdrivers/widgets/app_app_bar.dart';

class EarningsScreen extends StatelessWidget {
  static String id = "earningsScreen";
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: "Total Earnings"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Text("$previousDriverEarnings \$",
                style: const TextStyle(
                  fontSize: 80,
                  fontFamily: "Signatra",
                )),
            const Text("Total Earnings",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Signatra",
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            const SizedBox(width: 200, child: Divider(thickness: 2)),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Card(
                margin: EdgeInsets.symmetric(horizontal: 125),
                child: ListTile(
                  leading: Icon(Icons.arrow_back),
                  title: Text("Back",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
