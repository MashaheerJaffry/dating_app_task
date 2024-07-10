// ignore_for_file: prefer_const_constructors, unnecessary_set_literal

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simply_poem/screens/get_started/get_started_screen.dart';
import 'package:simply_poem/utils/constants/assets.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getValidation().whenComplete(() => {
          Timer(
            const Duration(seconds: 5),
            () {
              finalUid == null
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GetStarted(),
                      ),
                    )
                  : Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          )
        });
  }

  Future getValidation() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var obtainedUid = sp.getString('uid');
    setState(() {
      finalUid = obtainedUid;
    });
    print(finalUid);
  }

  String? finalUid;
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Image(
            image: AssetImage(CustomAssets.splashIcon),
          ),
        ),
      ),
    );
  }
}
