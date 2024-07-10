import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simply_poem/screens/get_started/get_started_screen.dart';
import 'package:simply_poem/utils/app_text.dart';

import 'filter_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.home),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FilterScreen(),
                  ),
                );
              },
              child: const Text(AppText.filterProfiles),
            ),
          ),
          10.verticalSpace,
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const GetStarted(),
                  ),
                );
              },
              child: const Text(AppText.signout),
            ),
          ),
        ],
      ),
    );
  }
}
