import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/login.view.dart';
import 'package:mytest/utils/global.colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 6), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Stack(
        children: [
          Center(
            child: Applogo(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class Applogo extends StatelessWidget {
  Applogo({
    super.key,
    this.color,
  });

  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 160,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/moreX.png',
              // width: MediaQuery.of(context).size.width,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text(
              'N C D s',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color ?? GlobalColors.mainColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Image.asset(
          //   'assets/images/moreX.png',
          //   width: MediaQuery.of(context).size.width,
          // ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'assets/images/moreX.png',
              // width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
