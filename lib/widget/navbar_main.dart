import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytest/pages/history/history_menu.dart';
import 'package:mytest/pages/home/home_menu.dart';
import 'package:mytest/pages/list/list_menu.dart';
import 'package:mytest/pages/personal/personal_menu.dart';
import 'package:mytest/utils/global.colors.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeMenu(),
    ListMenu(),
    HistoryMenu(),
    PersonalMenu()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'หน้าหลัก',
            backgroundColor: GlobalColors.mainColor
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.business),
            label: 'รายการ',
            backgroundColor: GlobalColors.mainColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school),
            label: 'ประวัติ',
            backgroundColor: GlobalColors.mainColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'ข้อมูลส่วนตัว',
            backgroundColor: GlobalColors.mainColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
