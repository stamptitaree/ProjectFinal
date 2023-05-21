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
      Get.to( LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Text('Logo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
    
  }
}
