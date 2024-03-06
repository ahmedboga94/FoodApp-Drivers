import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodappdrivers/global/global.dart';
import 'package:foodappdrivers/homescreens/home_screen.dart';
import 'package:foodappdrivers/maps/maps_utils.dart';
import 'package:foodappdrivers/widgets/app_app_bar.dart';
import 'package:foodappdrivers/widgets/custom_button.dart';
import 'package:foodappdrivers/widgets/error_dialog.dart';
import 'package:geolocator/geolocator.dart';

class ParcelDeliveringScreen extends StatefulWidget {
  final String? orderByUID;
  final String? sellerld;
  final String? getOrderId;

  const ParcelDeliveringScreen({
    super.key,
    this.orderByUID,
    this.sellerld,
    this.getOrderId,
  });

  @override
  State<ParcelDeliveringScreen> createState() => _ParcelDeliveringScreenState();
}

class _ParcelDeliveringScreenState extends State<ParcelDeliveringScreen> {
  bool isLoading = true;

  late Position driverPosition;
  late double userLat;
  late double userLng;

  late double orderTotalAmount;

  getUserOrderData() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get()
        .then((docSnapshot) {
      userLat = docSnapshot.data()!["userLat"];
      userLng = docSnapshot.data()!["userLng"];
      orderTotalAmount = docSnapshot.data()!["totalAmount"];
    }).then((value) => getSellerData());
  }

  getSellerData() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerld)
        .get()
        .then((docSnapshot) {
      previousSellerEarnings = docSnapshot.data()!["earning"].toDouble();
    });
  }

  getCurrentDriverLocation() async {
    setState(() {
      isLoading = true;
    });
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Future.delayed(const Duration(milliseconds: 1), () {
        showDialog(
            context: context,
            builder: (c) =>
                const ErrorDialog(message: "Permission not granted"));
      });
    } else {
      driverPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
    setState(() {
      isLoading = false;
    });
  }

  confirmParcelDelivered() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .update({
      "status": "ended",
      "earnings": perParcelDelivertAmount, //pay per delivery
    }).then((value) {
      FirebaseFirestore.instance
          .collection("drivers")
          .doc(sharedPreferences!.getString("uid"))
          .update({
        "earning": previousDriverEarnings +
            perParcelDelivertAmount, //total earnings amount of driver
      });
    }).then((value) {
      FirebaseFirestore.instance
          .collection("sellers")
          .doc(widget.sellerld)
          .update({
        "earning": orderTotalAmount +
            previousSellerEarnings, //total earnings amount of seller
      }).then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.orderByUID)
            .collection("orders")
            .doc(widget.getOrderId)
            .update({
          "status": "ended",
          "driverID": sharedPreferences!.getString("uid"),
        }).then((value) => Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false));
      });
    });
  }

  @override
  void initState() {
    getCurrentDriverLocation();
    getUserOrderData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppAppBar(title: "Parcel Delivering"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 300,
                  child: Image.asset("assets/images/confirm2.png")),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/images/home.png", width: 60),
                const SizedBox(width: 7),
                Column(
                  children: [
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => MapUtils.launchMapFromSourceToDestination(
                              driverPosition.latitude,
                              driverPosition.longitude,
                              userLat,
                              userLng),
                      child: const Text("Show User Location",
                          style: TextStyle(
                              fontFamily: "Signatra",
                              fontSize: 28,
                              letterSpacing: 1)),
                    ),
                  ],
                )
              ]),
              const SizedBox(height: 40),
              SizedBox(
                  height: 44,
                  child: CustomButton(
                      onPressed: () => confirmParcelDelivered(),
                      text: "Order has been deliverd - Confirm",
                      color: Colors.blueGrey))
            ],
          ),
        ));
  }
}
