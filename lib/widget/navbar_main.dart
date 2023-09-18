import 'package:flutter/material.dart';
import 'package:mytest/pages/history/history_menu.dart';
import 'package:mytest/pages/home/home_menu.dart';
import 'package:mytest/pages/list/list_menu.dart';
import 'package:mytest/pages/personal/personal_menu.dart';
import 'package:mytest/utils/global.colors.dart';

class BottomNavigationBarExample extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigationBarExample({Key? key, this.selectedIndex = 0})
      : super(key: key);

  @override
  State<BottomNavigationBarExample> createState() =>
      // ignore: no_logic_in_create_state
      _BottomNavigationBarExampleState(selectedIndex);
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex;

  _BottomNavigationBarExampleState(this._selectedIndex);
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
            icon: Image.asset(
              'assets/images/listW.png', 
              width: 24,
              height: 24,
            ),
            label: 'รายการ',
            backgroundColor: GlobalColors.mainColor,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/pillW.png', 
              width: 24,
              height: 24,
            ),
            label: 'ประวัติ',
            backgroundColor: GlobalColors.mainColor,
          ),
          BottomNavigationBarItem(
           icon: Image.asset(
              'assets/images/accountW.png', 
              width: 26,
              height: 26,
            ),
            label: 'ข้อมูลส่วนตัว',
            backgroundColor: GlobalColors.mainColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
