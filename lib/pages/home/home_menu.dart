import 'package:flutter/material.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/navbar_main.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarMain(),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             ],
          ),
        )),
      ),
      bottomNavigationBar: NavbarWidget(
        currentIndex: 0, // รายการ Home ถูกเลือกเป็นค่าเริ่มต้น
        onTabSelected: (index) {
          // ฟังก์ชันที่จะทำงานเมื่อมีการเลือกรายการใน Navbar
          print('Selected tab: $index');
        },
      ),
    
    );
  }
}