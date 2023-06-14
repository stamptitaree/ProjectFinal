import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mytest/pages/home/addpill.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/buttom_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarMain(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PressableContainer(
                onPressed: () {
                  Get.to(Addpill());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '+เพิ่มยา',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PressableContainer(
                onPressed: () {
                  print(0);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'รายการ',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PressableContainer(
                onPressed: () {
                  print(0);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ประวัติ',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PressableContainer(
                onPressed: () {
                  print(0);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ข้อมูลส่วนตัว',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
      drawer: const DrawerMain(),
    );
  }
}
