import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodappdrivers/homescreens/parcel_delivering_screen.dart';
import 'package:foodappdrivers/maps/maps_utils.dart';
import 'package:foodappdrivers/widgets/app_app_bar.dart';
import 'package:foodappdrivers/widgets/custom_button.dart';
import 'package:foodappdrivers/widgets/error_dialog.dart';
import 'package:geolocator/geolocator.dart';

class ParcelPickingScreen extends StatefulWidget {
  final String orderByUID;
  final String sellerld;
  final String getOrderId;

  const ParcelPickingScreen(
      {super.key,
      required this.orderByUID,
      required this.sellerld,
      required this.getOrderId});

  @override
  State<ParcelPickingScreen> createState() => _ParcelPickingScreenState();
}

class _ParcelPickingScreenState extends State<ParcelPickingScreen> {
  bool isLoading = true;

  late Position driverPosition;
  late double sellerLat;
  late double sellerLng;

  confirmParcelPicked() async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .update({
      "status": "delivering",
    }).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ParcelDeliveringScreen(
                orderByUID: widget.orderByUID,
                sellerld: widget.sellerld,
                getOrderId: widget.getOrderId,
              )));
    });
  }

  getSellerLocationData() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(widget.sellerld)
        .get()
        .then((docSnapshot) {
      sellerLat = docSnapshot.data()!["latitude"];
      sellerLng = docSnapshot.data()!["longitude"];
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

  @override
  void initState() {
    getCurrentDriverLocation();
    getSellerLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppAppBar(title: "Parcel Picking"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 300,
                  child: Image.asset("assets/images/confirm1.png")),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset("assets/images/restaurant.png", width: 50),
                const SizedBox(width: 7),
                Column(
                  children: [
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => MapUtils.launchMapFromSourceToDestination(
                              driverPosition.latitude,
                              driverPosition.longitude,
                              sellerLat,
                              sellerLng),
                      child: const Text("Show Cafe/Restaurant Location",
                          style: TextStyle(
                              fontFamily: "Signatra",
                              fontSize: 24,
                              letterSpacing: 1)),
                    ),
                  ],
                )
              ]),
              const SizedBox(height: 40),
              SizedBox(
                  height: 44,
                  child: CustomButton(
                      onPressed: () => confirmParcelPicked(),
                      text: "Order has been picked - Confirm",
                      color: Colors.blueGrey))
            ],
          ),
        ));
  }
}
