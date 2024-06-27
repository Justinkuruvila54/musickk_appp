// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:muzik/core/constants/texts.dart';
import 'package:muzik/global_widgets/bottom_nav.dart';
import 'package:muzik/presentation/home_page/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/get_screen.jpg"),
                  fit: BoxFit.cover)),
        ),
        Positioned(
          top: 60,
          left: 100,
          right: 70,
          child: Text(
            "Welcome to Muzik App..",
            style: MytextStyle.customWhiteHeadings4,
          ),
        ),
        Positioned(
            bottom: 100,
            right: 120,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageScreen(),
                      ));
                },
                child: Text(
                  "Let's Go..",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )))
      ]),
      // body: Image.network(
      //   "https://images.pexels.com/photos/3574678/pexels-photo-3574678.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
