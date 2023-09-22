import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytest/login.view.dart';
import 'package:mytest/utils/global.colors.dart';

class AppbarMain extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final FirebaseAuth _auth = FirebaseAuth.instance; 

  AppbarMain({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Center(child: Text(title,style: const TextStyle(fontFamily:'Prompt'),)),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await _auth.signOut(); // เรียกใช้งานการออกจากระบบ
                Get.offAll(LoginView());
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
