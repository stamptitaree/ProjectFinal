import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/utils/global.colors.dart';

class AppbarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppbarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: GlobalColors.mainColor,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Get.back();
          },
         icon: const Icon(Icons.logout_outlined)
         )
      ],
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.menu
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}