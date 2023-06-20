import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/utils/global.colors.dart';

class AppbarMain extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarMain({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Center(child: Text(title)),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
