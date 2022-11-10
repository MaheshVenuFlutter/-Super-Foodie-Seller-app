import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seller_app_new/global/global.dart';

import '../splashScreen/splash_screen.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  double sellersTotalearnings = 0;
  retriveSellerErnings() async {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snap) {
      setState(() {
        sellersTotalearnings =
            double.parse(snap.data()!["earnings"].toString());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveSellerErnings();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "₹ " + sellersTotalearnings.toString(),
                style: const TextStyle(
                    fontFamily: "Signatra", fontSize: 80, color: Colors.white),
              ),
              const Text(
                "Total Earnings",
                style: TextStyle(
                    fontFamily: "Signatra",
                    fontSize: 30,
                    color: Colors.blueGrey,
                    letterSpacing: 3),
              ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      (MaterialPageRoute(
                          builder: (c) => const MySplashScreen())),
                      (route) => false);
                },
                child: const Card(
                  color: Colors.blueGrey,
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  child: ListTile(
                    title: Text(
                      " Go Back ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
