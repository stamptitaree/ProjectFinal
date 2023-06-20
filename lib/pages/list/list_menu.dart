import 'package:flutter/material.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({super.key});

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  static const x = [{}, {}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppbarMain(title: 'รายการยา'),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('List')],
          ),
        )),
      ),
      drawer: const DrawerMain(),
    );
  }
}
