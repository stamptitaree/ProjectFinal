import 'package:flutter/material.dart';
import 'package:mytest/widget/appbar_main.dart';
import 'package:mytest/widget/drawer_main.dart';


class PersonalMenu extends StatefulWidget {
  const PersonalMenu({super.key});

  @override
  State<PersonalMenu> createState() => _PersonalMenuState();
}

class _PersonalMenuState extends State<PersonalMenu> {
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
              Text('Personal')
             ],
          ),
        )),
      ),
      drawer: const DrawerMain(),

    
    );
  }
}