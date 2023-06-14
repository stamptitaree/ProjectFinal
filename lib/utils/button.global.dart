// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/pages/home/home_menu.dart';
import 'package:mytest/utils/global.colors.dart';
import 'package:mytest/widget/navbar_main.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Get.to(const BottomNavigationBarExample());
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: const Text('Sing In',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }
}
