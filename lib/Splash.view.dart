import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/login.view.dart';
import 'package:mytest/utils/global.colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 10), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/moreX.png',
                    // width: MediaQuery.of(context).size.width,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'NCDs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Image.asset(
                //   'assets/images/moreX.png',
                //   width: MediaQuery.of(context).size.width,
                // ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/moreX.png',
                    // width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
