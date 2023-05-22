import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homeScreen.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => const HomeScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    goToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bgimg.jpg"),
              opacity: 0.2,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset(
            "assets/ustvLogo.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
