import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/utils/global.colors.dart';

class AppbarBack extends StatelessWidget implements PreferredSizeWidget {
  const AppbarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        // actions: <Widget>[
        //   IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: const Icon(Icons.logout_outlined))
        // ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
