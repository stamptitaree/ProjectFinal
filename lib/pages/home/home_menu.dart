import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mytest/pages/ndcs/list_drug.dart';
import 'package:mytest/pages/home/addpill.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/buttom_main.dart';
import 'package:mytest/widget/drawer_main.dart';
import 'package:mytest/widget/navbar_main.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppbarMain(title: 'เมนู'),
      body: SafeArea(
          child: Center(
        child: SizedBox(
          // alignment: Alignment.center,
          // color: Colors.blueGrey,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              PressableContainer(
                onPressed: () {
                  Get.to(() => const Addpill());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/pillsEx.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'เพิ่มยา',
                          style: TextStyle(fontSize: 26.0,fontFamily:'Prompt'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              PressableContainer(
                onPressed: () {
                  Get.offAll(() => const BottomNavigationBarExample(selectedIndex: 1));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/list.png',
                          width: 28,
                          height: 28,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'รายการยา',
                          style: TextStyle(fontSize: 26.0,fontFamily:'Prompt'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              PressableContainer(
                onPressed: () {
                  Get.offAll(() => const BottomNavigationBarExample(selectedIndex: 2));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/pill.png',
                          width: 28,
                          height: 28,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'ประวัติยา',
                          style: TextStyle(fontSize: 26.0,fontFamily:'Prompt'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              PressableContainer(
                onPressed: () {
                  Get.to(() => const ListDrug());
                  
            
               },
                child:  Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/health.png',
                          width: 28,
                          height: 28,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'ความรู้เรื่องโรค',
                          style: TextStyle(fontSize: 26.0,fontFamily:'Prompt'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      drawer:  const DrawerMain(),
    );
  }
}
