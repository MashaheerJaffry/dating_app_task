// ignore_for_file: unnecessary_new, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:simply_poem/utils/app_text.dart';
import 'package:simply_poem/widgets/buttonWidget.dart';

import 'login_with_phone.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonWidget(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginWithPhone()));
          },
          text: AppText.loginWithPhone,
        ),
      ),
    );
  }
}
